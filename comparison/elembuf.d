#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "elembuf" version="~>1.1.5"
dflags "-release" "-m64" "-boundscheck=off" "-O" platform="dmd"
dflags "-O4" "--release" "--boundscheck=off" platform="ldc2"
+/

// dmd.exe  -release -m64 -boundscheck=off -O  buffer.d
// ldc2 -O4 --release --boundscheck=off buffer.d

import buffer;

import std.stdio;
import std.datetime.stopwatch;
import core.atomic;
import core.thread, std.concurrency;

const n=1_000_000_000; //;_000
enum amount = n;


void main() //line 22
{
    Buffer!(size_t, true) buffer = Buffer!(size_t,true)();

	size_t srci = 0; // Source index
	size_t consi = 0; // Consumer index

    size_t sum = 0; 

    auto src = (size_t[] x) // Tell background thread about source //Line 30
    {
		const needToFill = amount - srci;

		if( x.length >= needToFill ) // Final fill!
		{
			foreach(i;0..needToFill){
				x[i] = srci;
				srci++;
			}
			return needToFill;
		}
		else // Long way to go still...
		{
			foreach(ref i;x){
				i = srci;
				srci++;
			}
			return x.length;
		}

    }; 

	buffer.fill = src;

	// START!
	StopWatch sw;
   	sw.start();  

	while(consi < amount)
	{
		buffer.fill();

		foreach(elem; buffer)
			sum += elem;

		consi += buffer.length;
		if(consi == amount)
			"breakpoint".writeln;

		buffer = buffer[$..$];
	}

	sw.stop();
   	writeln("finished receiving");
   	writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n, sw.peek().total!("msecs"), sum, n/sw.peek().total!("msecs"));

}
