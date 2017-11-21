MACHINE=myvirt
DEBUG= #gdb --args
QEMU_FLAGS=-bios ./ld/rom -nographic -M $(MACHINE) 

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

gdb: 
	xterm -e "gdb-multiarch -x gdbinit" &
	$(DEBUG) ./qemu/arm-softmmu/qemu-system-arm -s -S $(QEMU_FLAGS)

remote: 
	$(DEBUG) ./qemu/arm-softmmu/qemu-system-arm -s -S $(QEMU_FLAGS)

run: 
	$(DEBUG) ./qemu/arm-softmmu/qemu-system-arm $(QEMU_FLAGS)
		
