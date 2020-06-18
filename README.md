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

C is C, D is D. So let

* C manage C's memory (the container), and
* D manage D's memory (the objects)

The only thing interfacing is simple the (void*) as *value*.

* all primitive types | class (pointers)'s *value* are stored as value of (void*)
* all (fat) objects' *address* are stored as value of (void*)

The only extra requirement on the D side is to keep reference to those fat objects to avoid it being GC-ed before being pop-ed.

(Just as: don't push a stack var into any-type-of queue, and pop it after the stack is gone -- this is the responsibility of the *programmer*, not the container.)

That's all.

