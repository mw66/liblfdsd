DMD_DUB = DFLAGS="-release -m64 -boundscheck=off -O" ${DMD}/windows/bin/dub.exe
LDC_DUB = DFLAGS="-O4 --release --boundscheck=off" ${LDC}/bin/dub

ldcrun:
	$(LDC_DUB) rwqueue.d

dmdrun:
	$(DMD_DUB) rwqueue.d


javamp:
	javac ThroughputMpTest.java
	java  ThroughputMpTest

dmp:
	$(LDC_DUB) mp.d
