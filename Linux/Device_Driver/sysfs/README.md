# Linux Device Driver - Sysfs

## Overview

Sysfs is a virtual filesystem provided by the Linux kernel that exposes kernel objects, devices, drivers, and configuration parameters to user space.

It is mounted at:

```bash
/sys
```

Sysfs allows communication between:

```text
User Space <----> Sysfs <----> Kernel Space
```

Unlike regular filesystems, sysfs files do not store data on disk. Their contents are generated dynamically by the kernel when accessed.

---

# Why Sysfs?

Linux provides several mechanisms for communication between user space and kernel space:

* IOCTL
* Procfs
* Sysfs
* Debugfs
* Configfs
* Sysctl
* Netlink Sockets
* UDP Sockets

Among these:

| Interface | Purpose                            |
| --------- | ---------------------------------- |
| Procfs    | Process and system information     |
| Sysfs     | Device and driver information      |
| Debugfs   | Debugging information              |
| IOCTL     | Device-specific control operations |

Sysfs is the preferred mechanism for exposing device attributes and configuration parameters.

---

# Sysfs Filesystem Layout

```text
/sys
├── block
├── bus
├── class
├── devices
├── firmware
├── kernel
└── module
```

Example:

```bash
/sys/kernel/
```

---

# What is a Kobject?

The foundation of Sysfs is the Kernel Object (kobject).

A kobject:

* Represents a kernel object
* Creates directories in sysfs
* Maintains parent-child relationships
* Supports reference counting
* Connects kernel structures to sysfs

Defined in:

```c
#include <linux/kobject.h>
```

Simplified structure:

```c
struct kobject
{
    char *name;
    struct kobject *parent;
    struct kset *kset;
    struct kobj_type *ktype;
    struct kref kref;
};
```

Important fields:

| Field  | Purpose           |
| ------ | ----------------- |
| name   | Name of object    |
| parent | Parent directory  |
| kset   | Group of kobjects |
| ktype  | Object type       |
| kref   | Reference counter |

---

# Sysfs Driver Workflow

```text
Driver Loaded
      |
      v
Create Kobject
      |
      v
Create Sysfs File
      |
      v
User Reads/Writes
      |
      v
Show/Store Functions Called
      |
      v
Kernel Variable Updated
```

---

# Step 1 - Create Sysfs Directory

Function:

```c
struct kobject *
kobject_create_and_add(
        const char *name,
        struct kobject *parent);
```

Parameters:

| Parameter | Description    |
| --------- | -------------- |
| name      | Directory name |
| parent    | Parent kobject |

---

## Common Parents

### Under /sys

```c
kobject_create_and_add("mydir", NULL);
```

Creates:

```text
/sys/mydir
```

---

### Under /sys/kernel

```c
kobject_create_and_add(
        "mydir",
        kernel_kobj);
```

Creates:

```text
/sys/kernel/mydir
```

---

### Under /sys/firmware

```c
kobject_create_and_add(
        "mydir",
        firmware_kobj);
```

Creates:

```text
/sys/firmware/mydir
```

---

### Under /sys/fs

```c
kobject_create_and_add(
        "mydir",
        fs_kobj);
```

Creates:

```text
/sys/fs/mydir
```

---

## Example

```c
struct kobject *kobj_ref;

kobj_ref =
kobject_create_and_add(
        "etx_sysfs",
        kernel_kobj);
```

Result:

```text
/sys/kernel/etx_sysfs
```

---

# Releasing Kobject

Always release the kobject:

```c
kobject_put(kobj_ref);
```

---

# Step 2 - Create Sysfs File

After creating a directory, create files inside it.

Sysfs files are called Attributes.

Example:

```text
/sys/kernel/etx_sysfs/etx_value
```

---

# Attribute Functions

Every sysfs attribute requires:

1. Show function (Read)
2. Store function (Write)

---

## Show Function

Called when:

```bash
cat attribute_file
```

Prototype:

```c
static ssize_t sysfs_show(
        struct kobject *kobj,
        struct kobj_attribute *attr,
        char *buf);
```

Example:

```c
static ssize_t sysfs_show(
        struct kobject *kobj,
        struct kobj_attribute *attr,
        char *buf)
{
    return sprintf(buf,"%d",etx_value);
}
```

---

## Store Function

Called when:

```bash
echo value > attribute_file
```

Prototype:

```c
static ssize_t sysfs_store(
        struct kobject *kobj,
        struct kobj_attribute *attr,
        const char *buf,
        size_t count);
```

Example:

```c
static ssize_t sysfs_store(
        struct kobject *kobj,
        struct kobj_attribute *attr,
        const char *buf,
        size_t count)
{
    sscanf(buf,"%d",&etx_value);
    return count;
}
```

---

# Create Attribute

Macro:

```c
__ATTR(
        name,
        permission,
        show,
        store
);
```

Example:

```c
struct kobj_attribute etx_attr =
        __ATTR(
            etx_value,
            0660,
            sysfs_show,
            sysfs_store
        );
```

---

# File Permissions

| Permission | Meaning               |
| ---------- | --------------------- |
| 0444       | Read only             |
| 0664       | Read/Write            |
| 0660       | Owner & Group RW      |
| 0644       | Owner RW, Others Read |

Example:

```c
0660
```

Equivalent:

```bash
-rw-rw----
```

---

# Create Sysfs File

Function:

```c
sysfs_create_file(
        kobj_ref,
        &etx_attr.attr);
```

Example:

```c
if(sysfs_create_file(
        kobj_ref,
        &etx_attr.attr))
{
    pr_err("Sysfs creation failed\n");
}
```

Result:

```text
/sys/kernel/etx_sysfs/etx_value
```

---

# Remove Sysfs File

```c
sysfs_remove_file(
        kobj_ref,
        &etx_attr.attr);
```

---

# Complete Example

Kernel variable:

```c
volatile int etx_value = 0;
```

Create directory:

```c
kobj_ref =
kobject_create_and_add(
        "etx_sysfs",
        kernel_kobj);
```

Create file:

```c
sysfs_create_file(
        kobj_ref,
        &etx_attr.attr);
```

---

# User Space Access

## Read

```bash
cat /sys/kernel/etx_sysfs/etx_value
```

Output:

```text
0
```

---

## Write

```bash
echo 123 > \
/sys/kernel/etx_sysfs/etx_value
```

---

## Verify

```bash
cat /sys/kernel/etx_sysfs/etx_value
```

Output:

```text
123
```

---

# Build Driver

Makefile:

```make
obj-m += driver.o

KDIR = /lib/modules/$(shell uname -r)/build

all:
	make -C $(KDIR) \
	M=$(shell pwd) modules

clean:
	make -C $(KDIR) \
	M=$(shell pwd) clean
```

---

# Load Driver

```bash
sudo insmod driver.ko
```

Verify:

```bash
ls /sys/kernel
```

Output:

```text
etx_sysfs
```

---

# Unload Driver

```bash
sudo rmmod driver
```

---

# Sysfs vs Procfs

| Feature                  | Sysfs             | Procfs                  |
| ------------------------ | ----------------- | ----------------------- |
| Purpose                  | Devices & Drivers | Processes & System Info |
| Location                 | /sys              | /proc                   |
| Device Model Integration | Yes               | No                      |
| Attribute Based          | Yes               | No                      |
| Driver Configuration     | Yes               | Limited                 |

---

# Sysfs vs IOCTL

| Sysfs                | IOCTL              |
| -------------------- | ------------------ |
| File-based           | System call based  |
| Human readable       | Binary interface   |
| Easy debugging       | More flexible      |
| Simple configuration | Complex operations |

---

# Real Driver Use Cases

Common sysfs attributes:

```text
brightness
power
enable
frequency
temperature
fan_speed
voltage
gpio_value
```

Examples:

```text
/sys/class/leds/
/sys/class/gpio/
/sys/class/pwm/
/sys/class/thermal/
```

---

# Advantages

* Simple user-space interface
* Human-readable files
* Easy debugging
* Device model integration
* No custom application required
* Standard Linux mechanism

---

# Limitations

* One value per file
* Not suitable for large data transfer
* Not suitable for streaming data
* Not suitable for complex commands

---

# Key APIs Summary

## Kobject APIs

```c
kobject_create_and_add()
kobject_put()
```

## Attribute APIs

```c
__ATTR()
```

## Sysfs APIs

```c
sysfs_create_file()
sysfs_remove_file()
```

## Callback Functions

```c
show()
store()
```

---

# Key Takeaways

* Sysfs is mounted under `/sys`.
* Sysfs exports kernel and device information to user space.
* Every sysfs file maps to a kernel attribute.
* Reading a file invokes the `show()` callback.
* Writing a file invokes the `store()` callback.
* Kobjects create directories in sysfs.
* Sysfs is the preferred interface for driver configuration and status reporting.
* Commonly used in Linux device driver development for exposing device parameters.

```
```


## Conclusion
This is just a basic linux device driver which explains about the sysfs in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/sysfs-in-linux-kernel/
