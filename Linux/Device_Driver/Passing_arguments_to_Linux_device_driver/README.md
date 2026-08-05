# Linux Device Driver – Part 3: Passing Arguments to Device Driver

This repository demonstrates how to pass parameters (arguments) from user space to a Linux kernel module (device driver) when it is loaded.

## Goal

The goals of this example are:

- To define module parameters that can be set at load time
- To understand how different data types (for example `int`, `charp`, arrays) are handled as parameters
- To see how these values are used inside the driver code
- To practice loading a module with different argument values

## Concepts Covered

This example focuses on:

- Declaring module parameters using kernel macros
- Specifying default values and permissions for these parameters
- Accessing the parameter values inside `init` and other driver functions
- Observing the values via kernel logs

These concepts apply to both simple “hello world” style modules and more complex device drivers.

## How Module Parameters Work

In the Linux kernel, module parameters:

- Are declared in the driver source using macros (for example for integers, strings, or arrays)
- Can be set from user space when inserting the module using `insmod` or `modprobe`
- Appear in `/sys/module/<module_name>/parameters/` (subject to permissions), allowing runtime inspection and sometimes modification

This allows flexible configuration of driver behavior without recompiling.

## Files in this Repository

- `param_driver.c` – Example driver showing how to declare and use module parameters
- `Makefile` – Builds the kernel module using the kernel build system
- `README.md` – Documentation for this part

Rename files as needed to match your actual source.

## Building the Module

Ensure kernel headers and build tools are installed.

To build:

```bash
make
```

This should produce a `.ko` file (for example `param_driver.ko`).

To clean:

```bash
make clean
```

## Loading the Module with Arguments

Load the module with default parameters:

```bash
sudo insmod param_driver.ko
dmesg | tail
```

Load the module with custom parameters (example):

```bash
sudo insmod param_driver.ko myint=10 mystring="hello" myarray=1,2,3
dmesg | tail
```

Check `dmesg` (or `journalctl`) to verify that the driver prints the values of the parameters when it initializes.

If supported by your code, you can also inspect parameters via:

```bash
ls /sys/module/param_driver/parameters
cat /sys/module/param_driver/parameters/myint
```

Replace names with those used in your actual module.

## Unloading the Module

To remove the module:

```bash
sudo rmmod param_driver
dmesg | tail
```

Ensure your exit function runs cleanly and that no state depends on the module parameters after unload.

## Prerequisites

- Linux system with development tools and kernel headers
- Basic understanding of kernel modules from previous parts
- Familiarity with `insmod`, `rmmod`, `dmesg`, and possibly `modprobe`

-------------------------------------------------------------------------------------------------------------
This is just a basic linux device driver. This will explain how to pass the arguments to the linux device driver.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

You can check the video tutorial of this example here (https://www.youtube.com/watch?v=Z4jwi8SP5zs).

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/linux-device-driver-tutorial-part-3-passing-arguments-to-device-driver/

The Linux Device Driver Video Playlist - https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k

How to Setup Ubuntu and Raspberry PI - https://www.youtube.com/watch?v=e6gNeje3ljA
How to Setup BeagleBone and Cross compile the kernel - https://www.youtube.com/watch?v=am-dgmrMgYY&t 

