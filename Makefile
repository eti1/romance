all: qemu

qemu/Makefile: qemu/configure
	cd qemu ; \
	./configure --target-list=arm-softmmu

.PHONY: qemu
qemu: qemu/Makefile
	make -C qemu
