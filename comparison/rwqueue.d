#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "lock-free" version="~>0.1.2"
dependency "dests" version="0.3.1"
dflags "-release" "-m64" "-boundscheck=off" "-O" platform="dmd"
dflags "-O4" "--release" "--boundscheck=off" platform="ldc2"
+/

// dmd.exe  -release -m64 -boundscheck=off -O  rwqueue.d
// ldc2 -O4 --release --boundscheck=off rwqueue.d


import std.stdio;
import std.datetime;
import std.datetime.stopwatch;
import core.atomic;
import core.thread, std.concurrency;
import std.process;


const n=1_000_000_000; //; //;_000
enum amount = n;

void push(Q, T)(ref shared(Q) queue) {
	writeln("p tid:", thisThreadID);
        foreach (i; 0 .. amount)
        {
            while (queue.full)
                Thread.yield();
            queue.push/*!T*/(cast(shared T)i);
        }
}

void pop(Q, T)(ref shared(Q) queue) {
   writeln("c tid:", thisThreadID);
   StopWatch sw;
   sw.start();  
   long s = 0;
        foreach (i; 0 .. amount)
        {
            while (queue.empty)
                Thread.yield();
	    auto p = queue.pop();
            assert(p == i);  // p.i
	    s += p;
        }
   sw.stop();
   writeln("finished receiving");
   writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n, sw.peek.total!"msecs", s, n/sw.peek.total!"msecs");
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

void main() {
  test_lock_free_rwqueue();
  // test_jin_go_queue();
}

