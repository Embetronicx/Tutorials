# Linux Device Driver – Part 2: First Device Driver

This repository contains a simple Linux character device driver, based on an introductory device-driver tutorial. It shows how to create, build, load, and test a basic driver implemented as a loadable kernel module.

## Goal

The main goals of this example are:

- To register a simple character device with the kernel
- To expose a device file under `/dev`
- To implement minimal `open`, `close`, `read`, and `write` callbacks
- To learn how to build and insert a kernel module

## Files in this Repository

- `hello_world.c` – The main driver source file implementing a character device
- `Makefile` – Uses the kernel build system to build the module
- `README.md` – This documentation

You can rename these to match your actual filenames.

## How the Driver Works

This driver:

- Registers a character device with the kernel using a major/minor number  
- Creates a device class and device node so that a file appears under `/dev`  
- Defines a `file_operations` structure with callbacks for:
  - `open`
  - `release` (close)
  - `read`
  - `write`
- Prints kernel log messages for each operation so you can see when user space accesses the driver

You can view these messages using `dmesg` or `journalctl`, depending on your distribution.

## Building the Module

Make sure you have the kernel headers and build tools installed on your system.

To build:

```bash
make
```

If successful, this produces a `.ko` file (for example `first_driver.ko`).

To clean:

```bash
make clean
```

## Loading and Unloading the Module

Insert the module:

```bash
sudo insmod first_driver.ko
dmesg | tail
```

Check that:

- The module is listed in `lsmod`
- A corresponding device node is created under `/dev` (possibly via `udev`)

Remove the module:

```bash
sudo rmmod first_driver
dmesg | tail
```

Always verify that resources (device number, class, device) are cleaned up in the module’s exit function.

## Testing from User Space

After loading the driver and confirming the `/dev` node exists:

```bash
echo "test" | sudo tee /dev/your_device_name
sudo cat /dev/your_device_name
```

These commands exercise the `write` and `read` callbacks. Replace `/dev/your_device_name` with the actual node created by your driver.

## Prerequisites

- Linux system with kernel headers installed
- Basic C programming knowledge
- Familiarity with `make`, `insmod`, `rmmod`, and `dmesg`

------------------------------------------------------------------------------------------------------------
# Hello World LDD
- This is just a basic linux device driver. This kernel module will print some debug messages at the init and exit time.
- Please update your Beaglebone board's kernel directory in the Makefile.

## Build for Beaglebone:
```
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
```
	
## Build for Raspberry Pi or Virtualbox Ubuntu:
```
	sudo make
```
- Please refer this URL for the complete tutorial of this source code.
```
https://embetronicx.com/tutorials/linux/device-drivers/linux-device-driver-tutorial-part-2-first-device-driver/
```
- You can check the video tutorial of this project.
```
https://youtu.be/hMsA1bA1Upk and https://youtu.be/xqsro29xQPo
```
- The Linux Device Driver Video Playlist -
  ```
   https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k
	```
- How to Setup Ubuntu and Raspberry PI - ``` https://www.youtube.com/watch?v=e6gNeje3ljA ```
- How to Setup BeagleBone and Cross compile the kernel - ``` https://www.youtube.com/watch?v=am-dgmrMgYY&t ``` 
