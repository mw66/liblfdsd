
DMD_DFLAGS = -release -m64 -boundscheck=off -O
LDC_DFLAGS = -O4 --release --boundscheck=off

DMD_DUB = DFLAGS="$(DMD_DFLAGS)" ${DMD}/windows/bin/dub.exe
LDC_DUB = DFLAGS="$(LDC_DFLAGS)" ${LDC}/bin/dub

ldcrun:
	$(LDC_DUB) rwqueue.d

dmdrun:
	$(DMD_DUB) rwqueue.d


dlist:
	ldc2 $(LDC_DFLAGS) dlist_test.d dlist.d
	./dlist_test

javamp:
	javac ThroughputMpTest.java
	java  ThroughputMpTest

dmp:
	$(LDC_DUB) mp.d

