#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "elembuf" version="~>1.2.2"
dflags "-release" "-m64" "-boundscheck=off" "-O" platform="dmd"
dflags "-O4" "--release" "--boundscheck=off" platform="ldc2"
+/

import std.stdio;
import std.concurrency : receiveOnly, send, spawn, Tid, thisTid;
import std.datetime;
import core.atomic : atomicOp, atomicLoad, MemoryOrder;

import elembuf;

alias T = int;

/*
Queue that can be used safely among
different threads. All access to an
instance is automatically locked thanks to
synchronized keyword.
*/
synchronized class SafeQueue(T) // Syncronised is SLOW as it is a mutex on everything! Use atomics with a shared or __gshared variable.
{
    // Note: must be private in synchronized
    // classes otherwise D complains.
    //private T[] elements;
    alias BufferT = buffer!(T[], true);
    private BufferT elements;

    alias elements this;

    this(bool uselessVariable) // Constructor must not have 0 parameters.
	{
        // We cannot pass a buffer as it will deallocate when it exits scope. Thus we construct it here locally in the class and pass it on as a non-destructable global.
        elements = cast (shared) BufferT(); 
	}

    auto length()
	{
        return (cast(BufferT)elements).length;
	}

    void push(T value) 
	{

        // auto arr = [value];

        /*(cast(BufferT))*/ elements ~= value;

    }

    /// Return T.init if queue empty
    void pop() {
        //import std.array : empty;

		//if (elements.empty)
        cast(BufferT)elements = (cast(BufferT)elements)[1 .. $];
    }
}

//This must be a module variable so that once it exits producer scope, 
//it does not deallocate before the consumer is done
//this is due to RAII, but will be removed in 1.2.X with explicit deinit function calls.
shared SafeQueue!(T) queue; 

/*
Safely print messages independent of
number of concurrent threads.
Note that variadic parameters 
are used
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

shared int global_tls = 0;

void threadProducer(shared(int)* queueCounter)
{
    // Push values 0 to n-1
    foreach (i; 0..n) {

        while(queue.length == queue.max){} // You cannot fill forever, only fill when there is space available, i.e. buf.avail > 0
		queue.push(i); // Push will write element to available space. If pushed without available space, thread will error.

        //if(i % 1000 == 0)
        //safePrint("Pushed ", i);
        atomicOp!"+="(*queueCounter,1);
        atomicOp!"+="(global_tls,1);
    }
	safePrint("threadProducer:", atomicLoad(global_tls));
}

void threadConsumer(Tid owner,
					shared(int)* queueCounter)
{

	StopWatch sw;
	sw.start();  
	long s = 0;

    int popped = 0;
    while (popped != n) // IMPORTANT! This was popped = n, but it should be < n, because we start from 0, so the last pop should be n-1
	{
        if(queue.length == 0)
            continue;
  
		s += queue[0];
        // if (i == int.init) continue; //If you wish sum to be correct, this should not be done as the first item should be 0.
        //safePrint("Popped ", queue[0], " (Consumer pushed ", atomicLoad(*queueCounter), ")");
        queue.pop;
        ++popped;
        // safely fetch current value of
        // queueCounter using atomicLoad
		atomicOp!"-="(global_tls,1);
    }

	sw.stop();
	safePrint("threadConsumer:", atomicLoad(global_tls));
	safePrint("finished receiving");
	safePrint("received ",n," messages in ",sw.peek().msecs," msec sum=",s," speed=",n/sw.peek().msecs," msg/msec");

    // I'm done!
    owner.send(true); // Only send this after you are actually done and not printing.
}

void main()
{
    queue = new shared(SafeQueue!T)(true);
    // Buffer would deallocate when it exits the first spawn function scope if it were constructed here.
    // Thus we construct it inside the class. See EXPERT -level docs.
    shared int counter = 0;

    spawn(&threadProducer, &counter);
	auto consumer = spawn(&threadConsumer, thisTid, &counter);
	
	auto stopped = receiveOnly!bool;
    assert(stopped);

    //readln; // Had to add this as it goes away too fast for me. REMOVE THIS LINE!

}

