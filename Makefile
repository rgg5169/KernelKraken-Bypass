obj-m := KernalKraken.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
	go build init-patch.go

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

test:
	sudo dmesg -C
	sudo insmod KernalKraken.ko
	sudo lsmod | grep KernalKraken
	sudo rmmod KernalKraken.ko
	dmesg

install:
	sudo dmesg -C
	sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="init=\/bin\/init-patch"/g' /etc/default/grub
	sudo cp ./init-patch /bin/init-patch
	sudo cp ./KernalKraken.ko /lib/KernalKraken.ko
	sudo update-grub

purge:
	sudo rmmod KernalKraken.ko
	dmesg
