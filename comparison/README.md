
```
# test 1-producer-1-consumer lock-free queue
$ make ldc1p1c
received 1000000000 messages in 9845 msec sum=499999999500000000 speed=101574 msg/msec
received 1000000000 messages in 6219 msec sum=499999999500000000 speed=160797 msg/msec

$ make dmd1p1c
received 1000000000 messages in 53607 msec sum=499999999500000000 speed=18654 msg/msec


# test dlist: Lock-free deques and doubly linked lists
$ make dlist
ldc2 -O4 --release --boundscheck=off dlist_test.d dlist.d
received 1000000000 messages in 119041 msec sum=499999999500000000 speed=8400 msg/msec


# compare message passing between Java & D
$ make javamp
10000000 messages received in 778.0 ms, sum=49999995000000 speed: 0.0778 microsec/message, 12853.470437017995 messages/msec

$ make dmp
received 100000000 messages in 27574 msec sum=4999999950000000 speed=3626 msg/msec


# go.d using ldc
$ make go_d
received 100000000 messages in 2906 msec sum=4999999950000000 speed=34411 msg/msec


# elembuf backed plain D sync queue
$ make elembuf_sync_q
received 100000000 messages in 27078 msec sum=5000000050000000 speed=3693 msg/msec
```
