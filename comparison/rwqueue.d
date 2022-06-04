#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "lock-free" version="~>0.1.2"
dependency "dests" version="0.3.1"
dependency "rust_interop_d" version="0.2.2"
dflags "-release" "-m64" "-boundscheck=off" "-O" platform="dmd"
dflags "-O4" "--release" "--boundscheck=off" platform="ldc2"
+/

/*
 */
// dmd.exe  -release -m64 -boundscheck=off -O  rwqueue.d
// ldc2 -O4 --release --boundscheck=off rwqueue.d


import std.exception;
import std.stdio;
import std.datetime;
import std.datetime.stopwatch;
import core.atomic;
import core.thread, std.concurrency;
import std.process;


const long n=100_000_000; //; //; //;_000
enum amount = n;

void push(Q, T)(ref shared(Q) queue) {
	writeln("p tid:", thisThreadID);
        foreach (i; 0 .. amount)
        {
            while (queue.full)
                Thread.yield();
            queue.push(/*cast(shared T)*/i);
        }
}

void pop(Q, T)(ref shared(Q) queue) {
   writeln("c tid:", thisThreadID);
   StopWatch sw;
   sw.start();  
   long sum = 0;
        foreach (i; 0 .. amount)
        {
            while (queue.empty)
                Thread.yield();
	    auto p = queue.pop();
            enforce(p == i);  // p.i
	    sum += p;
        }
   sw.stop();
   long expected = (n / 2) * (n-1);  // avoid overflow
   writeln("finished receiving");
   writefln("received %d messages in %d msec sum:%d speed=%d msg/msec; %d", n, sw.peek.total!"msecs", sum, n/sw.peek.total!"msecs", expected);
   enforce(expected == sum);
}


void run_test(Q, T)(ref shared(Q) queue) {
    auto t0 = new Thread({push!(Q, T)(queue);}),
         t1 = new Thread({ pop!(Q, T)(queue);});
    t0.start();
    t1.start();
    t0.join();
    t1.join();
    thread_joinAll();
}

//struct Data { size_t i; }

alias Data = size_t;


// received 100000000 messages in 1339 msec sum:4999999950000000 speed=74682 msg/msec; 4999999950000000
void test_lock_free_rwqueue() {
    import lock_free.rwqueue;
    shared(RWQueue!Data) queue;
    run_test!(RWQueue!Data, Data)(queue);
}

/*
void test_jin_go_queue() {
    import jin_go_queue;
    shared Queue!Data queue = new Queue!Data;
    run_test!(Queue!Data, Data)(queue);
}
*/

// received 100000000 messages in 18938 msec sum:4999999950000000 speed=5280 msg/msec; 4999999950000000
void test_rust_queue() {
    import rust_interop;
    auto queue = new shared(SegQueue);
    run_test!(SegQueue, Data)(queue);
}

void main() {
  test_lock_free_rwqueue();
  // test_jin_go_queue();
  test_rust_queue();
}

