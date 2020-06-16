#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "lock-free" version="~>0.1.2"
dflags "-release" "-m64" "-boundscheck=off" "-O" platform="dmd"
dflags "-O4" "--release" "--boundscheck=off" platform="ldc2"
+/

// dmd.exe  -release -m64 -boundscheck=off -O  rwqueue.d
// ldc2 -O4 --release --boundscheck=off rwqueue.d


import std.stdio;
import std.datetime;
import core.atomic;
import core.thread, std.concurrency;
import std.process;


const n=1_000_000_000; //;_000
enum amount = n;

void push(Q, T)(ref shared(Q) queue) {
	writeln("p tid:", thisThreadID);
        foreach (i; 0 .. amount)
        {
            while (queue.full)
                Thread.yield();
            queue.push(cast(shared T)i);
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
            //assert(p.i == cast(shared T)i);
	    s += p.i;
        }
   sw.stop();
   writeln("finished receiving");
   writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n, sw.peek().msecs, s, n/sw.peek().msecs);
}


void run_test(Q, T)(ref shared(Q) queue) {
    auto t0 = new Thread({push!(Q, T)(queue);}),
         t1 = new Thread({ pop!(Q, T)(queue);});
    t0.start();
    t1.start();
    t0.join();
    t1.join();
}

void test_lock_free_rwqueue() {
    import lock_free.rwqueue;
    static struct Data { size_t i; }
    shared(RWQueue!Data) queue;
    run_test!(RWQueue!Data, Data)(queue);
}


void main() {
  test_lock_free_rwqueue();
}

