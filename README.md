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
```
