#!/usr/bin/env dub
/+ dub.sdl:
+/
import std.concurrency, std.stdio;
import std.datetime;

const n=100000000;
void main() {
    auto tid=spawn(&receiver);
    setMaxMailboxSize(tid, 1000, OnCrowding.block);
    tid.send(thisTid);
    foreach(i; 0..n) {
       tid.send(i); 
    }
    writeln("finished sending");
    auto s=receiveOnly!(string)();
    writeln("received ", s);
}

void receiver() {
   auto mainTid=receiveOnly!(Tid)();
   StopWatch sw;
   sw.start();  
   long s;
   for(auto i=0;i<n;i++) {
      auto msg = receiveOnly!(int)();
      s+=msg;
      //writeln("received ", msg);
   }
   sw.stop();
   writeln("finished receiving");
   writefln("received %d messages in %d msec sum=%d speed=%d msg/sec", n, sw.peek().msecs, s, n*1000L/sw.peek().msecs);
   mainTid.send("finished");
}
