MACHINE=myvirt
DEBUG= #gdb --args

all: qemu

qemu/Makefile: qemu/configure
	cd qemu ; \
	./configure --target-list=arm-softmmu

.PHONY: qemu
qemu:
	CFLAGS="-g -Wno-missing-prototypes" make -C qemu

.PHONY: rpm
rpm:
	make -C ld

run: 
	xterm -e "gdb-multiarch -x gdbinit" &
	$(DEBUG) ./qemu/arm-softmmu/qemu-system-arm -M $(MACHINE) -s -S \
		-bios ./ld/rom 	-display gtk
