This is just a basic linux device driver. This will explain about the device file and how to create that in the linux device driver.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

You can check the video tutorial of this example here (added soon).

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/device-file-creation-for-character-drivers/
