# cdev Structure and File Operations of Character Drivers

This repository demonstrates how to use the Linux kernel `cdev` structure and `file_operations` to implement a character device driver. It follows modern kernel practices for character drivers instead of the older `register_chrdev()` approach.

## Goal

The main goals of this example are:

- To understand the role of the `cdev` structure in character drivers
- To define and register `file_operations` callbacks (`open`, `read`, `write`, `release`, etc.)
- To use the modern kernel API (`alloc_chrdev_region`, `cdev_init`, `cdev_add`, etc.) to register a character device
- To create a device file under `/dev` automatically using a device class

## What Is `cdev`?

In modern Linux kernels:

- `cdev` represents a character device in the kernel
- Each `cdev` is associated with:
  - A device number range (major/minor)
  - A `file_operations` structure that defines how to handle I/O

Instead of using the old `register_chrdev()` directly, you:

1. Allocate a device number range with `alloc_chrdev_region()`
2. Initialize a `cdev` with `cdev_init()`
3. Set its `file_operations`
4. Add it to the system with `cdev_add()`
5. Clean up with `cdev_del()` and `free_chrdev_region()`

This approach is more flexible and aligns with the kernel’s internal device model.

## File Operations (`file_operations`)

The `file_operations` structure defines callbacks that the kernel invokes when user space performs operations on the device file:

Common callbacks include:

| Callback       | Purpose                                      |
|----------------|----------------------------------------------|
| `open`         | Called when the device file is opened        |
| `read`         | Called when data is read from the device     |
| `write`        | Called when data is written to the device    |
| `release`      | Called when the device file is closed        |
| `unlocked_ioctl` | Optional: for ioctl commands (if needed)   |

Your driver defines these functions and assigns them to a `struct file_operations`:

```c
static const struct file_operations fops = {
    .open = my_open,
    .read = my_read,
    .write = my_write,
    .release = my_release,
};
```

Then this is linked to the `cdev` via `cdev_init()`.

## Key Kernel APIs Used

Typical APIs for a modern character driver:

- `alloc_chrdev_region(&dev, 0, 1, MY_CLASS_NAME)` – Allocate device numbers
- `cdev_init(&cd, &fops)` – Initialize `cdev` with file operations
- `cdev_add(&cd, dev, 1)` – Register the character device
- `cdev_del(&cd)` – Remove the character device
- `free_chrdev_region(dev, 1)` – Free the allocated device numbers
- `class_create()` / `device_create()` – Create device class and node under `/dev`
- `class_destroy()` / `device_destroy()` – Cleanup

Your exact code may use slightly different names depending on kernel version and the tutorial.

## Files in this Repository

- `cdev_fileops.c` – Driver source implementing a character device using `cdev` and `file_operations`
- `Makefile` – Builds the kernel module using the kernel build system
- `README.md` – This documentation

Rename files to match your actual source.

## Building the Module

Ensure kernel headers and tools are installed.

To build:

```bash
make
```

This should produce a `.ko` file (for example `cdev_fileops.ko`).

To clean:

```bash
make clean
```

## Loading the Module

Insert the module:

```bash
sudo insmod cdev_fileops.ko
dmesg | tail
```

Check:

- The driver prints the major number and confirms device registration
- A device node appears under `/dev` (e.g., `/dev/mydev`)
- The device is listed in `/proc/devices` and under `/sys/class/`

## Unloading the Module

To remove the module:

```bash
sudo rmmod cdev_fileops
dmesg | tail
```

Ensure the driver:

- Removes the device node (`device_destroy()`)
- Destroys the device class (`class_destroy()`)
- Deletes the `cdev` (`cdev_del()`)
- Frees the device number range (`free_chrdev_region()`)

## Testing from User Space

Once the device node exists:

```bash
echo "hello" | sudo tee /dev/your_device_name
sudo cat /dev/your_device_name
```

This exercises `write` and `read` callbacks if they are implemented. Replace `/dev/your_device_name` with the actual device name.

## Prerequisites

- Linux system with kernel headers and build tools
- Basic understanding of character devices and kernel modules
- Familiarity with `make`, `insmod`, `rmmod`, `dmesg`, and `/proc/devices`
- Comfort reading and writing C code for the kernel

## Conclusion
This is just a basic linux device driver which explains about the file operations.

Please update your Beaglebone board's kernel directory in the Makefile.

Build for Beaglebone:
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

Build for Raspberry Pi or Virtualbox Ubuntu:
	sudo make

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/cdev-structure-and-file-operations-of-character-drivers/

You can check the video tutorial of this example here (https://youtu.be/20dQsadVdII).

The Linux Device Driver Video Playlist - https://www.youtube.com/watch?v=BRVGchs9UUQ&list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k

How to Setup Ubuntu and Raspberry PI - https://www.youtube.com/watch?v=e6gNeje3ljA
How to Setup BeagleBone and Cross compile the kernel - https://www.youtube.com/watch?v=am-dgmrMgYY&t 
