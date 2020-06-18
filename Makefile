
LIBLFDS = ./liblfds7.1.1

DPPFLAGS = --preprocess-only --hard-fail --include-path=$(LIBLFDS)/liblfds711/inc --keep-d-files --compiler=ldmd2 #dmd #ldc2 #
LDC2_FLAGS = -O4 --release --boundscheck=off
LDC2_FLAGS = -debug #-d
DMDLIB = -L$(LIBLFDS)/liblfds711/bin -L-L. -L-llfdsd -L-llfds711

d:
	gcc $(CFLAGS) -c queue_bmm.c
	ar rcs liblfdsd.a queue_bmm.o
	d++ $(DPPFLAGS)  liblfds.dpp
	ldmd2 -unittest -version=LIBLFDS_TEST liblfds.d $(LDC2_FLAGS) -L$(DMDLIB)
	./liblfds


CFLAGS = -I$(LIBLFDS)/liblfds711/inc -Ofast # -std=gnu11
LIB = -L$(LIBLFDS)/liblfds711/bin -llfds711

c:
	gcc $(CFLAGS)    queue_bmm_test.c  $(LIB)  -o queue_bmm_test

