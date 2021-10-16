This is just a basic linux device driver. This kernel module will print some debug messages at the init and exit time.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/linux-device-driver-tutorial-part-2-first-device-driver/

You can check the video tutorial of this project.
https://youtu.be/hMsA1bA1Upk and https://youtu.be/xqsro29xQPo

The Linux Device Driver Video Playlist - https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k

How to Setup Ubuntu and Raspberry PI - https://www.youtube.com/watch?v=e6gNeje3ljA
How to Setup BeagleBone and Cross compile the kernel - https://www.youtube.com/watch?v=am-dgmrMgYY&t 
