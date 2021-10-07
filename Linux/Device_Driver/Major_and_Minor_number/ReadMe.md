This is just a basic linux device driver. This will explain major and minor number in the linux device driver.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

You can check the video tutorial of this example here (https://www.youtube.com/watch?v=TfUTkCMCyig).

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/character-device-driver-major-number-and-minor-number/
