all: qemu

qemu/Makefile: qemu/configure
	cd qemu ; \
	./configure --target-list=arm-softmmu

.PHONY: qemu
qemu: qemu/Makefile
	CFLAGS=-g make -C qemu
