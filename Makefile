
LIBLFDS = ./liblfds7.1.1

DPPFLAGS = --preprocess-only --hard-fail --include-path=$(LIBLFDS)/liblfds711/inc --keep-d-files --compiler=ldmd2 #dmd #ldc2 #
LDC2_FLAGS = -debug #-d
LDC2_FLAGS = -O4 --release --boundscheck=off
DMDLIB = -L$(LIBLFDS)/liblfds711/bin -L-L. -L-llfdsd -L-llfdsdc -L-llfds711

build:
	dub build

gen:
	make clean
	tar xjf lib/liblfds\ release\ 7.1.1\ source.tar.bz2
	# https://liblfds.org/mediawiki/index.php?title=r7.1.1:Building_Guide_(liblfds)
	cd liblfds7.1.1/liblfds711/build/gcc_gnumake && make ar_rel
	mv -f liblfds7.1.1/liblfds711/bin/liblfds711.a .
	sed 's/bmm/bss/g;s/BMM/BSS/g' queue_bmm.h > queue_bss.h
	# echo sed 's/bmm/umm/g' queue_bmm.h > queue_umm.h  # one time run, then need manual edit
	gcc $(CFLAGS) -c liblfdsd.c
	ar rcs liblfdsdc.a liblfdsd.o
	d++ $(DPPFLAGS)  liblfdsd.dpp
	mv -f liblfdsd.d source/

test:
	ldmd2 -unittest -version=LIBLFDS_TEST source/liblfdsd.d $(LDC2_FLAGS) -L$(DMDLIB)
	./liblfdsd

liblfdsd.d: liblfdsd.h

CFLAGS = -I$(LIBLFDS)/liblfds711/inc -Ofast # -g # -std=gnu11
LDFLAGS = -L$(LIBLFDS)/liblfds711/bin -llfds711

c:
	make clean
	gcc $(CFLAGS)  queue_bmm_test.c  $(LDFLAGS)  -o queue_bmm_test
	gcc $(CFLAGS)  queue_bss_test.c  $(LDFLAGS)  -o queue_bss_test
	gcc $(CFLAGS)  queue_umm_test.c  $(LDFLAGS)  -o queue_umm_test
	./queue_bmm_test
	./queue_bss_test
	./queue_umm_test



clean:
	$(RM) -fr liblfds7.1.1/ *.o *.a
	dub clean
