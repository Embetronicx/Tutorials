# Linux Device Driver Tutorial – Programming (Real Device Driver)

This repository contains a complete “real” Linux character device driver and a matching user-space test application, based on the EmbetronicX Linux Device Driver tutorial series. It demonstrates how to:

- Implement kernel-space driver functions: `open`, `write`, `read`, and `close` (release)
- Allocate and free kernel memory with `kmalloc()` and `kfree()`
- Safely copy data between user space and kernel space using `copy_from_user()` and `copy_to_user()`
- Use `cdev`, major/minor numbers, and automatic device file creation under `/dev`
- Build a kernel module and a user-space application, and test them together

Source code for the original examples is available at:  
https://github.com/Embetronicx/Tutorials/tree/master/Linux/Device_Driver/Real_device_driver

The full tutorial series is at:  
https://www.youtube.com/playlist?list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k  
Website: https://embetronicx.com/linux-device-driver-tutorials/

## Concept

- A **user-space application** communicates with a **kernel-space driver** via a device file (e.g. `/dev/etx_device`).
- When the user writes data to the device file, the driver:
  - Copies the data from user space to kernel space using `copy_from_user()`
  - Stores it in a kernel-allocated buffer (via `kmalloc()`)
- When the user reads the device file, the driver:
  - Copies the stored data from kernel space back to user space using `copy_to_user()`
  - Returns it to the user-space application

This implements a simple “write once, read later” buffer in kernel memory.

## Files in This Repository

- `driver.c` – Kernel-space character device driver source
- `test_app.c` – User-space application to test the driver
- `Makefile` – Builds the kernel module (`driver.ko`)
- `README.md` – This documentation

You can download the original code from:  
https://github.com/Embetronicx/Tutorials/tree/master/Linux/Device_Driver/Real_device_driver

## Key Kernel Functions Used

### `kmalloc()`

Allocates memory in kernel space (like `malloc()` in user space).

```c
#include <linux/slab.h>
void *kmalloc(size_t size, gfp_t flags);
```

- `size`: number of bytes to allocate
- `flags`: memory type, e.g.:
  - `GFP_KERNEL` – normal kernel memory (may sleep)
  - `GFP_USER` – for user behalf (may sleep)
  - `GFP_ATOMIC` – no sleep (e.g. interrupt handlers)

The memory is physically contiguous and not cleared.

### `kfree()`

Frees previously allocated kernel memory:

```c
void kfree(const void *objp);
```

- `objp`: pointer returned by `kmalloc()`

### `copy_from_user()`

Copies data from user space to kernel space:

```c
#include <linux/uaccess.h>
unsigned long copy_from_user(void *to, const void __user *from, unsigned long n);
```

- `to`: destination in kernel space
- `from`: source in user space
- `n`: number of bytes to copy

Returns number of bytes that could not be copied (0 on success).

### `copy_to_user()`

Copies data from kernel space to user space:

```c
unsigned long copy_to_user(const void __user *to, const void *from, unsigned long n);
```

- `to`: destination in user space
- `from`: source in kernel space
- `n`: number of bytes to copy

Returns number of bytes that could not be copied (0 on success).

## File Operations in the Driver

The driver implements four main operations:

1. **`open`** – Called when the device file is opened.  
   - In this tutorial’s sample, it logs a message; the original full driver also allocates memory in `init`.
2. **`write`** – Called when data is written to the device file.  
   - Uses `copy_from_user()` to copy data from user space into `kernel_buffer`.
3. **`read`** – Called when data is read from the device file.  
   - Uses `copy_to_user()` to copy data from `kernel_buffer` back to user space.
4. **`release` (close)** – Called when the device file is closed.  
   - Frees the kernel buffer with `kfree()`.

## Driver Overview

Key points from `driver.c`:

- Uses modern kernel APIs:
  - `alloc_chrdev_region()`, `cdev_init()`, `cdev_add()`
  - `class_create()`, `device_create()` for automatic `/dev/etx_device`
- Allocates a kernel buffer of size `mem_size` (1024 bytes) with `kmalloc()`.
- Initializes the buffer with `"Hello_World"` in the init function.
- Implements:
  - `etx_open()`
  - `etx_release()`
  - `etx_read()` using `copy_to_user()`
  - `etx_write()` using `copy_from_user()`

## Building the Device Driver

### Native Build (Ubuntu / Raspberry Pi)

```bash
sudo make
```

This produces `driver.ko`.

### Cross-Compile for BeagleBone (ARM)

```bash
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
```

Make sure your `Makefile` has the correct BeagleBone kernel build path set in `KDIR`.

Download the original Makefile from:  
https://github.com/Embetronicx/Tutorials/tree/master/Linux/Device_Driver/Real_device_driver

Clean:

```bash
sudo make clean
```

## Compiling the User-Space Application

### Native (x86)

```bash
gcc -o test_app test_app.c
```

### For BeagleBone (ARM)

```bash
arm-linux-gnueabihf-gcc -o test_app test_app.c
```

## Execution (Output)

1. Load the driver:

```bash
sudo insmod driver.ko
dmesg | tail
```

You should see:

- Major/minor number printed
- “Device Driver Insert...Done!!!”

2. Run the application:

```bash
sudo ./test_app
```

Example interaction:

```text
**
**WWW.EmbeTronicX.com**
**Please Enter the Option**
 1. Write
 2. Read
 3. Exit
**
Select option 1 to write data to the driver and write the string (e.g. "embetronicx").

1
Your Option = 1
Enter the string to write into driver :embetronicx
Data Writing ...Done!
```

The string is passed to the driver and stored in kernel memory.

Now select option 2 to read:

```text
2
Your Option = 2
Data Reading ...Done!

Data = embetronicx
```

You now see the same string read back from kernel space.

3. Exit:

```text
3
```

The device file is closed and the application exits.

Check `dmesg` to see:

- “Device File Opened...!!!”
- “Data Write : Done!”
- “Data Read : Done!”
- “Device File Closed...!!!”

To remove the driver:

```bash
sudo rmmod driver
dmesg | tail
```

You should see “Device Driver Remove...Done!!!”.

## Using `echo` and `cat` Instead of the Application

Instead of `test_app`, you can use shell commands:

Write:

```bash
echo "embetronicx" | sudo tee /dev/etx_device
```

Read:

```bash
sudo cat /dev/etx_device
```

This exercises the same `write` and `read` callbacks.

## Prerequisites

- Linux system (Ubuntu, Raspberry Pi, or BeagleBone) with kernel headers
- Basic C programming knowledge
- Familiarity with:
  - `make`, `gcc`
  - `insmod`, `rmmod`, `dmesg`
  - Device files under `/dev`

## Minimal Build Environment (Ubuntu)

```bash
sudo apt update
sudo apt install -y build-essential linux-headers-$(uname -r)
```

## Credits and Note on Copyright

This repository contains example code inspired by the EmbetronicX Linux Device Driver tutorial series.  
Refer to the original tutorial for detailed explanations, diagrams, and exact source code:

- Tutorial page: https://embetronicx.com/tutorials/linux/device-drivers/linux-device-driver-tutorial-programming/
- YouTube playlist: https://www.youtube.com/playlist?list=PLArwqFvBIlwHq8WMKgsXSQdqIvymrEz9k
- GitHub source: https://github.com/Embetronicx/Tutorials/tree/master/Linux/Device_Driver/Real_device_driver

Please respect the author’s intellectual property. Do not copy the tutorial’s code verbatim unless you have permission. Use these examples as learning aids and adapt them in your own words and style.
## Conclusion
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
