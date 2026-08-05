# Character Device Driver: Major and Minor Numbers

This repository demonstrates how to create a Linux character device driver that explicitly uses and manages major and minor numbers. It covers static and dynamic major number allocation and how these numbers relate to device files under `/dev`.

## Goal

The main goals of this example are:

- To understand the role of major and minor numbers in character devices
- To register a character device with a specific major number (static allocation)
- To demonstrate dynamic major number allocation using the kernel API
- To show how major/minor numbers are associated with device files in `/dev`

## What Are Major and Minor Numbers?

In Linux:

- The **major number** identifies the driver that controls a device.
- The **minor number** is used by the driver to distinguish between multiple devices or instances controlled by the same driver.

Example:

```text
/dev/mydev0  → major=<N>, minor=0
/dev/mydev1  → major=<N>, minor=1
```

Multiple minor numbers can share the same major number, allowing one driver to manage several devices.

Character devices historically had fixed major numbers in `/proc/devices` or header files, but modern kernels typically use dynamically allocated major numbers.

## Key Kernel APIs Used

This driver typically uses:

- `register_chrdev()` or `register_chrdev_region()` to register a character device region
- `alloc_chrdev_region()` to allocate a range of device numbers dynamically
- `cdev_init()` and `cdev_add()` to create and add a kernel `cdev` structure
- `device_create()` (often via a device class) to create a device node under `/dev`
- Cleanup functions: `cdev_del()`, `put_device()`, and `unregister_chrdev_region()` or `free_chrdev_region()`

Your exact code may use a simpler old-style `register_chrdev()`/`unregister_chrdev()` depending on the tutorial.

## Files in this Repository

- `char_dev_major_minor.c` – Driver source implementing a character device with major/minor handling
- `Makefile` – Build script using the kernel build system
- `README.md` – This documentation

Rename files to match your actual source.

## Building the Module

Ensure kernel headers and tools are installed.

To build:

```bash
make
```

This should produce a `.ko` file (for example `char_dev_major_minor.ko`).

To clean:

```bash
make clean
```

## Viewing Registered Devices

After building, you can inspect current devices:

```bash
cat /proc/devices
```

Look for your driver’s name and its major number.

## Loading the Module

Insert the module:

```bash
sudo insmod char_dev_major_minor.ko
dmesg | tail
```

Check:

- The major number printed in kernel logs
- The device file created under `/dev` (e.g., `/dev/mydev`)
- The entry in `/proc/devices`

You can also inspect dynamic device info:

```bash
ls /sys/class/<your_class_name>/
ls /dev/
```

## Unloading the Module

To remove the module:

```bash
sudo rmmod char_dev_major_minor
dmesg | tail
```

Ensure that all resources (device numbers, `cdev`, device nodes) are properly freed.

## Testing from User Space

Once the device node exists:

```bash
echo "test" | sudo tee /dev/your_device_name
sudo cat /dev/your_device_name
```

This exercises the driver’s `read` and `write` callbacks if they are implemented.

Replace `/dev/your_device_name` with the actual device name created by your driver.

## Prerequisites

- Linux system with kernel headers and build tools
- Basic understanding of character devices and kernel modules
- Familiarity with `make`, `insmod`, `rmmod`, `dmesg`, and `/proc/devices`

-----------------------------------------------------------------------------------------------------------
This is just a basic linux device driver. This will explain major and minor number in the linux device driver.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

You can check the video tutorial of this example here (https://www.youtube.com/watch?v=TfUTkCMCyig) and (https://youtu.be/aTwBCUjtTnw).

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/character-device-driver-major-number-and-minor-number/

The Linux Device Driver Video Playlist - https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k

How to Setup Ubuntu and Raspberry PI - https://www.youtube.com/watch?v=e6gNeje3ljA
How to Setup BeagleBone and Cross compile the kernel - https://www.youtube.com/watch?v=am-dgmrMgYY&t 
