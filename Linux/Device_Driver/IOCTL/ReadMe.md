# ioctl Tutorial in Linux Device Drivers

This repository demonstrates how to implement and use `ioctl` (Input/Output Control) in a Linux character device driver. It shows how to add custom commands beyond basic `read`/`write` and how user-space applications can invoke them via the `ioctl()` system call.

`ioctl` is commonly used for:

- Device configuration (e.g., setting modes, speeds, parameters)
- Control operations (e.g., start/stop, reset, enable/disable)
- Querying device status or capabilities

Reference: Linux kernel documentation on ioctl-based interfaces [web:15].

## Goal

The main goals of this example are:

- To define custom `ioctl` commands using the kernel’s `_IO*` macros
- To implement an `unlocked_ioctl` (or `ioctl`) function in the driver
- To safely pass arguments between user space and kernel space
- To show how a user-space application calls `ioctl()` on a device file

## What Is `ioctl`?

`ioctl` is a system call for device-specific control operations that don’t fit naturally into `read`/`write`.  

In user space:

```c
#include <sys/ioctl.h>
int ioctl(int fd, unsigned long request, ...);
```

- `fd`: file descriptor of the device (from `open()`)
- `request`: ioctl command code
- Optional argument: pointer to data or an integer value

In the kernel driver:

```c
#include <linux/ioctl.h>
#include <linux/uaccess.h>

static long unlocked_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
    // handle cmd and arg
}
```

Reference: O’Reilly’s “The ioctl Method” in Linux Device Drivers [web:12].

## Defining ioctl Commands

Custom ioctl commands are defined using macros from `<linux/ioctl.h>`:

```c
#define MY_IOC_MAGIC  'k'

#define MY_IOC_HELLO  _IO(MY_IOC_MAGIC, 0)        // no argument
#define MY_IOC_SETVAL _IOW(MY_IOC_MAGIC, 1, int)  // write (user -> kernel)
#define MY_IOC_GETVAL _IOR(MY_IOC_MAGIC, 2, int)  // read (kernel -> user)
#define MY_IOC_BOTH   _IOWR(MY_IOC_MAGIC, 3, int) // read-write
```

Key macros:

- `_IO(magic, nr)`         – no argument
- `_IOW(magic, nr, type)` – write (user → kernel)
- `_IOR(magic, nr, type)` – read (kernel → user)
- `_IOWR(magic, nr, type)` – read-write

- `magic`: a unique character (e.g., `'k'`) to distinguish your driver
- `nr`: command number
- `type`: C type of the argument (e.g., `int`, `struct my_config`)

Reference: Example ioctl command definitions in a Linux driver repo [web:11].

## File Operations with ioctl

In the driver, you define a `file_operations` structure that includes `unlocked_ioctl`:

```c
static const struct file_operations fops = {
    .owner = THIS_MODULE,
    .open = my_open,
    .release = my_release,
    .read = my_read,
    .write = my_write,
    .unlocked_ioctl = my_ioctl,
};
```

The `unlocked_ioctl` prototype:

```c
static long my_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
    switch (cmd) {
        case MY_IOC_HELLO:
            // no arg
            break;
        case MY_IOC_SETVAL:
            {
                int val;
                if (copy_from_user(&val, (int __user *)arg, sizeof(int)))
                    return -EFAULT;
                // use val in kernel
                break;
            }
        case MY_IOC_GETVAL:
            {
                int val = /* some kernel value */;
                if (copy_to_user((int __user *)arg, &val, sizeof(int)))
                    return -EFAULT;
                break;
            }
        default:
            return -EINVAL;
    }
    return 0;
}
```

Key points:

- Use `copy_from_user()` to get data from user space.
- Use `copy_to_user()` to send data to user space.
- Return `-EINVAL` for unknown commands.
- Return `-EFAULT` if copy fails.

Reference: Example `unlocked_ioctl` implementation in a Linux driver [web:11].

## Files in This Repository

- `ioctl_driver.c` – Kernel driver with custom ioctl commands
- `ioctl_test.c`  – User-space application that calls `ioctl()`
- `Makefile`       – Builds both the kernel module and user app
- `README.md`      – This documentation

Rename files to match your actual source.

## Building the Kernel Module

Ensure kernel headers and tools are installed.

To build the module:

```bash
make module
```

This produces `ioctl_driver.ko`.

To build the user-space app:

```bash
make app
```

This produces `ioctl_test`.

To clean:

```bash
make clean
```

## Loading the Module

Insert the module:

```bash
sudo insmod ioctl_driver.ko
dmesg | tail
```

Check:

- The driver prints major/minor numbers and confirms device creation
- A device node appears under `/dev` (e.g., `/dev/ioctl_dev`)

## Running the User-Space Application

```bash
sudo ./ioctl_test
```

Typical interactions:

```text
1. Hello (no arg)
2. Set value
3. Get value
4. Exit
```

Examples:

- **Hello**: calls `ioctl(fd, MY_IOC_HELLO, 0)`
- **Set value**: calls `ioctl(fd, MY_IOC_SETVAL, &val)`
- **Get value**: calls `ioctl(fd, MY_IOC_GETVAL, &val)` and prints the returned value

The driver logs each ioctl command in `pr_info()`/`pr_err()`. Check with:

```bash
dmesg | tail
```

## Unloading the Module

```bash
sudo rmmod ioctl_driver
dmesg | tail
```

Ensure the driver:

- Removes the device node
- Destroys the device class
- Deletes the `cdev`
- Unregisters the chrdev region

## Example ioctl Commands

Common patterns:

| Command          | Direction      | Example Use                    |
|------------------|----------------|--------------------------------|
| `MY_IOC_HELLO`   | none           | Simple “hello” control         |
| `MY_IOC_SETVAL`  | user → kernel  | Set a parameter (e.g., mode)   |
| `MY_IOC_GETVAL`  | kernel → user  | Get current parameter value    |
| `MY_IOC_BOTH`    | both           | Configure and query together   |

Reference: Example ioctl commands like `_IO`, `_IOW`, `_IOR` in a Linux driver [web:11].

## Prerequisites

- Linux system with kernel headers and build tools
- Basic C programming knowledge
- Familiarity with:
  - `make`, `gcc`
  - `insmod`, `rmmod`, `dmesg`
  - Device files under `/dev`
  - `ioctl()` system call in user space

## Minimal Build Environment (Ubuntu)

```bash
sudo apt update
sudo apt install -y build-essential linux-headers-$(uname -r)
```

## Conclusion
This is just a basic linux device driver which explains about the IOCTL.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/ioctl-tutorial-in-linux/
