#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "elembuf" version="~>1.1.5"
+/

import std.stdio;
import std.concurrency : receiveOnly, send, spawn, Tid, thisTid;
import std.datetime;
import core.atomic : atomicOp, atomicLoad;

import buffer;

/*
Queue that can be used safely among
different threads. All access to an
instance is automatically locked thanks to
synchronized keyword.
*/
synchronized class SafeQueue(T)
{
    // Note: must be private in synchronized
    // classes otherwise D complains.
    //private T[] elements;
    alias BufferT = Buffer!T;  // (T, true);
    private BufferT elements;

    void push(T value) {
        // auto arr = [value];
        cast(BufferT)elements << [value]; //.fill(cast(T[])arr);
    }

    /// Return T.init if queue empty
    T pop() {
        //import std.array : empty;
        T value;
	//if (elements.empty)
        if (0 == (cast(BufferT)elements).length)
            return value;
        value = elements[0];
        cast(BufferT)elements = (cast(BufferT)elements)[1 .. $];
        return value;
    }
}

/*
Safely print messages independent of
number of concurrent threads.
Note that variadic parameters are used
for args! That is args might be 0 .. N
parameters.
*/
void safePrint(T...)(T args)
{
    // Just executed by one concurrently
    synchronized {
        import std.stdio : writeln;
        writeln(args);
    }
}

const n=100_000_000;

int global_tls = 0;

void threadProducer(shared(SafeQueue!int) queue,
    shared(int)* queueCounter)
{
    import std.range : iota;
    // Push values 1 to n
    foreach (i; 1..n+1) {
        queue.push(i);
        // safePrint("Pushed ", i);
        atomicOp!"+="(*queueCounter, 1);
	global_tls += 1;
    }
   writeln("threadProducer:", global_tls);
}

void threadConsumer(Tid owner,
    shared(SafeQueue!int) queue,
    shared(int)* queueCounter)
{
   StopWatch sw;
   sw.start();  
   long s = 0;

    int popped = 0;
    while (popped != n) {
        auto i = queue.pop();
	s += i;
        if (i == int.init) continue;
        ++popped;
        // safely fetch current value of
        // queueCounter using atomicLoad
        // safePrint("Popped ", i, " (Consumer pushed ", atomicLoad(*queueCounter), ")");
	global_tls -= 1;
    }

    // I'm done!
    owner.send(true);

   sw.stop();
   writeln("threadConsumer:", global_tls);
   writeln("finished receiving");
   writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n, sw.peek().msecs, s, n/sw.peek().msecs);
}

void main()
{
    auto queue = new shared(SafeQueue!int);
    shared int counter = 0;

    spawn(&threadProducer, queue, &counter);
    auto consumer = spawn(&threadConsumer, thisTid, queue, &counter);
    auto stopped = receiveOnly!bool;
    assert(stopped);

   writeln("main:", global_tls);

}
