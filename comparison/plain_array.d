#!/usr/bin/env dub
/+ dub.sdl:
+/

import std.datetime.stopwatch;
import std.stdio;

const n=1_000_000_000; //;_000

void main() {
  long[] arr = new long[n];
  long sum = 0;

  StopWatch sw;
  sw.start();

  foreach (i; 0..n) {
    arr[i] = i;
  }
  foreach (i; 0..n) {
    sum += arr[i];
  }

  sw.stop();

  writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n,
      sw.peek.total!"msecs", sum, n / sw.peek.total!"msecs");
  
  assert(sum == (n * (n - 1) / 2));
}
