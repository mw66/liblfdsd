
DMD_DFLAGS = -release -m64 -boundscheck=off -O
LDC_DFLAGS = -O4 --release --boundscheck=off

DMD_DUB = DFLAGS="$(DMD_DFLAGS)" ${DMD}/windows/bin/dub.exe
LDC_DUB = DFLAGS="$(LDC_DFLAGS)" ${LDC}/bin/dub

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

plain_d_sync_queue:
	ldc2 $(LDC_DFLAGS) plain_d_sync_queue.d
	./plain_d_sync_queue
