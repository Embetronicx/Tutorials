This is just a basic linux device driver which explains about the real read and write of the device file.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

Build the application using the below command for Ubuntu and Raspberry Pi.
		gcc -o test_app test_app.c
Build the application using the below command for BeagleBone.	
		arm-linux-gnueabihf-gcc -o test_app test_app.c


Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/linux-device-driver-tutorial-programming/

You can check the video tutorial of this project - https://youtu.be/xp9HTR6a98I

The Linux Device Driver Video Playlist - https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k

How to Setup Ubuntu and Raspberry PI - https://www.youtube.com/watch?v=e6gNeje3ljA
How to Setup BeagleBone and Cross compile the kernel - https://www.youtube.com/watch?v=am-dgmrMgYY&t 
