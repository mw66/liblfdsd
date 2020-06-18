# liblfdsd
liblfds for d, from the portable, license-free, lock-free data structure C library (https://www.liblfds.org/)

## Deps:
1. https://code.dlang.org/packages/dpp
2. https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Queue_(bounded,_many_producer,_many_consumer) 
   #### download from https://www.liblfds.org/downloads/liblfds%20release%207.1.1%20source.tar.bz2

## test

After install deps:

```
$ make d
$ ./liblfds
string: Madge The Skutter; after push & before pop
string: Madge The Skutter; after push & before pop
skutter name = struct: Madge The Skutter; after push & before pop 8
skutter name = class: Madge The Skutter; after push & before pop 8
received 100000000 messages in 4632 msec sum=4999999950000000 speed=21588 msg/msec
received 100000000 messages in 4868 msec sum=4999999950000000 speed=20542 msg/msec
```

## Design, user must read to use this wrapper library!

### to use this libary, you have to know how the orginal C library work

Please read the C-doc before using this D wrapper lib:

https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Release_7.1.1_Documentation

E.g.

"
To make those initial values valid (which is to say, visible) upon other logical cores, threads on those cores need to issue the define


https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Define_LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE
"

It’s ugly macro of that C lib need to be called, but need to live with it.

And even laughable this:

"
The LFDS711_QUEUE_BMM_QUERY_GET_POTENTIALLY_INACCURATE_COUNT query is not guaranteed to be accurate. Where enqueue and dequeue operations are not guaranteed to be visible by the time the function calls return, similarly, it may be that a count will during its operation not see an element which has been enqueued, or see that an element has been dequeued. In general however it should be bang on; it's just it's not guaranteed.

https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Function_lfds711_queue_bmm_query#Notes
"

Yet, this library is the best time tested open source library on the internet. I have no interest to re-invent the wheels, or make the wrapper universal.

Because it’s much better than the ~4x times slower fewly-used D queues I have found.


### This is a thin wrapper in D

C is C, D is D. So let

* C manage C's memory (the container), and
* D manage D's memory (the objects)

The only thing interfacing is simple the (void*) as *value*.

* all primitive types | class (pointers)'s *value* are stored as value of (void*)
* all (fat) objects' *address* are stored as value of (void*)

The only extra requirement on the D side is to keep reference to those fat objects to avoid it being GC-ed before being pop-ed.

(Just as: don't push a stack var into any-type-of queue, and pop it after the stack is gone -- this is the responsibility of the *programmer*, not the container.)

That's all.

