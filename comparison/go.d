#!/usr/bin/env dub
/+ dub.sdl:
name "app"
dependency "jin-go" version="~>2.0.0"
+/

import std.datetime.stopwatch;
import std.stdio;

import jin.go;

const int n = 100_000_000;

void threadProducer(Output!int queue)
{
  foreach (int i; 0..n) {
	queue.put(i);
  }
}

void main()
{
	Input!int queue;
	jin.go.go.go!threadProducer(queue.pair);

	StopWatch sw;
	sw.start();
	long sum = 0;

	foreach (p; queue)
	{
		sum += p;
	}

	sw.stop();

	writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n,
			sw.peek.total!"msecs", sum, n / sw.peek.total!"msecs");
	
	assert(sum == (n * (n - 1) / 2));
}
