
```
# test 1-producer-1-consumer lock-free queue

$ make ldcrun
...
received 1000000000 messages in 9845 msec sum=499999999500000000 speed=101574 msg/msec


$ make dmdrun
...
received 1000000000 messages in 53607 msec sum=499999999500000000 speed=18654 msg/msec


# test dlist: Lock-free deques and doubly linked lists
$ make dlist
received 1000000000 messages in 119041 msec sum=499999999500000000 speed=8400 msg/msec


# compare message passing between Java & D

$ make javamp
10000000 messages received in 1151.0 ms, sum=49999995000000 speed: 0.1151 microsec/message, 8688.097306689835 messages/msec

$ make dmp
received 100000000 messages in 27574 msec sum=4999999950000000 speed=3626 msg/msec

```
