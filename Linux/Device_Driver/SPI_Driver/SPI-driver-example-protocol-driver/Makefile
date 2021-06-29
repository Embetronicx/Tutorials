obj-m += spissd1306.o
spissd1306-objs := spi_ssd1306_driver.o ssd1306.o
 
KDIR = /lib/modules/$(shell uname -r)/build
 
 
all:
	make -C $(KDIR)  M=$(shell pwd) modules
 
clean:
	make -C $(KDIR)  M=$(shell pwd) clean
