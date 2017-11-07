MACHINE=myvirt
DEBUG= #valgrind

all: qemu

qemu/Makefile: qemu/configure
	cd qemu ; \
	./configure --target-list=arm-softmmu

.PHONY: qemu
qemu:
	CFLAGS=-g make -C qemu

.PHONY: rpm
rpm:
	make -C ld

run: qemu rpm
	xterm -e "gdb-multiarch -x gdbinit" &
	$(DEBUG) ./qemu/arm-softmmu/qemu-system-arm -M $(MACHINE) -s -S -bios ./ld/rom
