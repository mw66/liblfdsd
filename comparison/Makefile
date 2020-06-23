
DMD_DFLAGS = -release -m64 -boundscheck=off -O
LDC_DFLAGS = -O4 --release --boundscheck=off

DMD_DUB = DFLAGS="$(DMD_DFLAGS)" ${DMD}/windows/bin/dub.exe
LDC_DUB = DFLAGS="$(LDC_DFLAGS)" ${LDC}/bin/dub

array:
	$(LDC_DUB) plain_array.d

ldc1p1c:
	$(LDC_DUB) rwqueue.d

dmd1p1c:
	$(DMD_DUB) rwqueue.d


dlist:
	ldc2 $(LDC_DFLAGS) dlist_test.d dlist.d
	./dlist_test

javamp:
	javac ThroughputMpTest.java
	java  ThroughputMpTest

dmp:
	$(LDC_DUB) mp.d

elembuf_wait_free:
	$(LDC_DUB) build --single elembuf_wait_free_queue.d
	./app

elembuf_sync_q:
	$(LDC_DUB) elembuf_sync_queue.d

go_d:
	$(LDC_DUB) go.d

jin_go_q:
	ldc2 $(LDC_DFLAGS) rwqueue.d jin_go_queue.d

clean:
	$(RM) *.o
