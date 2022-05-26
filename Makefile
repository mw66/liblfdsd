
LIBLFDS = ./liblfds7.1.1

DPPFLAGS = --preprocess-only --hard-fail --include-path=$(LIBLFDS)/liblfds711/inc --keep-d-files --compiler=ldmd2 #dmd #ldc2 #
LDC2_FLAGS = -O4 --release --boundscheck=off
LDC2_FLAGS = -debug #-d
DMDLIB = -L$(LIBLFDS)/liblfds711/bin -L-L. -L-llfdsd -L-llfds711

d:
	make clean
	sed 's/bmm/bss/g;s/BMM/BSS/g' queue_bmm.h > queue_bss.h
	# sed 's/bmm/umm/g' queue_bmm.h > queue_umm.h  # one time run, then need manual edit
	gcc $(CFLAGS) -c queue_bmm_bss.c
	ar rcs liblfdsd.a queue_bmm_bss.o
	d++ $(DPPFLAGS)  liblfds.dpp
	ldmd2 -unittest -version=LIBLFDS_TEST liblfds.d $(LDC2_FLAGS) -L$(DMDLIB)
	./liblfds


CFLAGS = -I$(LIBLFDS)/liblfds711/inc -Ofast # -std=gnu11
LDFLAGS = -L$(LIBLFDS)/liblfds711/bin -llfds711

c:
	make clean
	gcc $(CFLAGS)  queue_bmm_test.c  $(LDFLAGS)  -o queue_bmm_test
	gcc $(CFLAGS)  queue_bss_test.c  $(LDFLAGS)  -o queue_bss_test
	./queue_bmm_test
	./queue_bss_test



clean:
	$(RM) *.o *.a
