# Device File Creation for Character Drivers

This repository demonstrates how to create device files (device nodes) under `/dev` for a Linux character device driver. It covers both manual creation and automatic creation using kernel APIs and udev.

## Goal

The main goals of this example are:

- To understand why device files are needed for character drivers
- To manually create a device file (for example with `mknod`)
- To automatically create a device file using kernel classes and device APIs
- To see how `udev` rules can control device node names and permissions

## Why Device Files?

In Linux:

- User-space programs interact with devices via device files like `/dev/mydev`
- The kernel uses these files to route I/O to the correct driver
- The device file encodes the major and minor number of the device

Without a device file, a character driver is registered but not easily usable from user space.

## Manual Device File Creation

A traditional approach is:

1. Register the character device with a known major number
2. Use `mknod` to create the device file manually:

```bash
sudo mknod /dev/mydev c <major> 0
```

where:

- `c` indicates a character device
- `<major>` is the major number assigned to your driver
- `0` is the minor number

This method is simple but not ideal for modern systems because:

- The device file won’t be recreated automatically on reboot
- It doesn’t integrate well with dynamic device management

## Automatic Device File Creation

Modern kernels use `udev` to manage device nodes automatically. Common approaches in the driver:

- Create a device class with `class_create()` (or the newer `device_class` API)
- Create a device with `device_create()` (or `dev_device_create()` variants)
- The kernel then asks `udev` to create a device node under `/dev` automatically

This approach:

- Recreates device nodes automatically on boot/reload
- Supports permissions and naming via udev rules
- Is the recommended method for modern drivers

Key APIs often used:

- `class_create()` / `device_create()` (older style)
- `device_class` and related helpers (newer style)
- Cleanup with `class_destroy()` / `device_destroy()`

Your exact code may vary depending on the kernel version and tutorial style.

## Files in this Repository

- `dev_file_creation.c` – Driver source that creates a character device and device file
- `Makefile` – Builds the kernel module using the kernel build system
- `README.md` – This documentation
- (Optional) `udev.rules` – Example udev rule file for custom naming/permissions

Rename files to match your actual source.

## Building the Module

Ensure kernel headers and tools are installed.

To build:

```bash
make
```

This should produce a `.ko` file (for example `dev_file_creation.ko`).

To clean:

```bash
make clean
```

## Loading the Module

Insert the module:

```bash
sudo insmod dev_file_creation.ko
dmesg | tail
```

Check:

- The driver prints the major number and confirms device creation
- A device node appears under `/dev` (e.g., `/dev/mydev`)
- The device is listed in `/proc/devices` and/or under `/sys/class/`

## Unloading the Module

To remove the module:

```bash
sudo rmmod dev_file_creation
dmesg | tail
```

Ensure the driver:

- Removes the device node (`device_destroy()` or equivalent)
- Destroys the device class (`class_destroy()` or equivalent)
- Unregisters the character device region

## Testing from User Space

Once the device node exists:

```bash
echo "hello" | sudo tee /dev/your_device_name
sudo cat /dev/your_device_name
```

This exercises `write` and `read` callbacks if they are implemented. Replace `/dev/your_device_name` with the actual device name.

## Customizing Device Name and Permissions with udev

You can:

- Create a udev rule file (for example `/etc/udev/rules.d/99-mydev.rules`)
- Control the device node name and permissions (e.g. `MODE="0666"`)

Example rule:

```text
KERNEL=="mydev", NAME="mydev", MODE="0666"
```

Then reload udev rules:

```bash
sudo udevadm control --reload-rules
```

## Prerequisites

- Linux system with kernel headers and build tools
- Basic understanding of character devices and kernel modules
- Familiarity with `insmod`, `rmmod`, `dmesg`, `mknod`, and `udev`

## Conclusion
This is just a basic linux device driver. This will explain about the device file and how to create that in the linux device driver.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

You can check the video tutorial of this example here (https://youtu.be/nRG8DdsjQdE).

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/device-file-creation-for-character-drivers/

The Linux Device Driver Video Playlist - https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k

How to Setup Ubuntu and Raspberry PI - https://www.youtube.com/watch?v=e6gNeje3ljA
How to Setup BeagleBone and Cross compile the kernel - https://www.youtube.com/watch?v=am-dgmrMgYY&t 
