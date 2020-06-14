DPPFLAGS = --include-path=../lib/liblfds7.1.1/liblfds711/inc --keep-d-files --compiler=ldc2 #dmd #
LDC2_FLAGS = #-O4 --release --boundscheck=off
DMDLIB = -L../lib/liblfds7.1.1/liblfds711/bin -L-llfds711
d:
	gcc $(CFLAGS) -c queue_bmm.c
	d++ $(DPPFLAGS)  liblfds.dpp $(LDC2_FLAGS) -L$(DMDLIB) queue_bmm.o

CFLAGS = -I../lib/liblfds7.1.1/liblfds711/inc  # -std=gnu11
LIB = -L../lib/liblfds7.1.1/liblfds711/bin -llfds711

c:
	gcc $(CFLAGS)    queue_bmm_test.c  $(LIB)  -o queue_bmm_test

