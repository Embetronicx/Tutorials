# procfs in Linux – Kernel Module Example

- This repository demonstrates how to create and use entries in the **proc filesystem (procfs)** from a Linux kernel module.
-  It shows how to expose kernel data to user space via `/proc` files and how to implement read/write operations for proc entries.

> **Note:** For modern device drivers, `sysfs` is preferred over `procfs` for configuration and status. `procfs` is mainly intended for process-related and global kernel information, and its use by drivers is discouraged for new production code [web:22][web:23]. This example is primarily for learning and debugging.

## What Is procfs?

`procfs` is a virtual filesystem mounted at `/proc`. It:

- Exists in RAM (not on disk)
- Provides kernel and system runtime information
- Acts as a bridge between kernel space and user space
- Allows user-space programs to read (and sometimes write) kernel data

Common examples:

- `/proc/cpuinfo` – CPU information
- `/proc/meminfo` – Memory statistics
- `/proc/[pid]` – Process-specific information [web:22]

For kernel modules, you can create your own entries under `/proc` to:

- Export driver variables or status
- Receive configuration from user space (by writing to the file)
- Debug kernel module behavior [web:22][web:26]

## Types of proc Entries

You can create:

1. **Read-only entries** – Expose kernel data to user space
2. **Read-write entries** – Allow user space to both read and configure kernel data

Reference: procfs as a kernel-to-user-space interface [web:27].

## Key procfs APIs

### Creating a proc Directory

```c
#include <linux/proc_fs.h>
#include <linux/exportfs.h>

struct proc_dir_entry *proc_mkdir(const char *name, struct proc_dir_entry *parent);
```

- `name`: directory name under `/proc`
- `parent`: parent directory (or `NULL` for root `/proc`)

Example:

```c
struct proc_dir_entry *my_dir = proc_mkdir("mydriver", NULL);
// Creates /proc/mydriver
```

### Creating a proc File (Modern API, kernel ≥ 3.10)

```c
struct proc_dir_entry *proc_create(
    const char *name,
    umode_t mode,
    struct proc_dir_entry *parent,
    const struct proc_ops *ops   // or file_operations in older kernels
);
```

- `name`: file name (e.g., `"status"`)
- `mode`: file permissions (e.g., `0444` for read-only, `0644` for read-write)
- `parent`: parent directory (or `NULL`)
- `ops`: pointer to `proc_ops` (or `file_operations` in older kernels)

Example:

```c
static struct proc_ops my_proc_ops = {
    .proc_read = my_proc_read,
    .proc_write = my_proc_write,
};

struct proc_dir_entry *entry = proc_create(
    "mydriver_status",
    0644,
    NULL,
    &my_proc_ops
);
// Creates /proc/mydriver_status
```

For kernel ≥ 5.6, use `struct proc_ops` instead of `struct file_operations` [web:26].

### Older API (kernel < 3.10)

Older kernels used:

```c
static struct file_operations proc_fops = {
    .open = open_proc,
    .read = read_proc,
    .write = write_proc,
    .release = release_proc,
};

struct proc_dir_entry *entry = create_proc_read_entry(
    "mydriver_status",
    0644,
    NULL,
    read_proc,
    NULL
);
```

This is deprecated in modern kernels.

### Removing proc Entries

```c
void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
void proc_remove(struct proc_dir_entry *entry);
```

- `remove_proc_entry()` removes a file or directory
- `proc_remove()` removes a directory and its contents

Example in module exit:

```c
remove_proc_entry("mydriver_status", NULL);
remove_proc_entry("mydriver", NULL);
```

Reference: Removing proc entries in module exit [web:21].

## Implementing proc Read and Write

### `proc_ops` (Modern)

```c
#include <linux/proc_fs.h>
#include <linux/uaccess.h>

static ssize_t my_proc_read(struct file *file, char __user *buf,
                            size_t count, loff_t *offset)
{
    static const char *data = "Hello from procfs\n";
    size len = strlen(data);

    if (*offset >= len)
        return 0;
    if (count > len - *offset)
        count = len - *offset;

    if (copy_to_user(buf, data + *offset, count))
        return -EFAULT;

    *offset += count;
    return count;
}

static ssize_t my_proc_write(struct file *file, const char __user *buf,
                             size_t count, loff_t *offset)
{
    char kernel_buf;
    int len = min(count, 63);

    if (copy_from_user(kernel_buf, buf, len))
        return -EFAULT;

    kernel_buf[len] = '\0';
    pr_info("procfs write: %s\n", kernel_buf);

    return count;
}

static struct proc_ops my_proc_ops = {
    .proc_read = my_proc_read,
    .proc_write = my_proc_write,
};
```

Key points:

- Use `copy_to_user()` and `copy_from_user()` for safety
- Return number of bytes handled
- Return `-EFAULT` on copy failure

Reference: Creating procfs entries with read/write and removing them [web:26].

## Files in This Repository

- `procfs_driver.c` – Kernel module that creates proc entries
- `Makefile` – Builds the kernel module
- `README.md` – This documentation

Rename files to match your actual source.

## Building the Module

Ensure kernel headers and tools are installed.

```bash
make
```

This produces `procfs_driver.ko`.

Clean:

```bash
make clean
```

## Loading the Module

```bash
sudo insmod procfs_driver.ko
dmesg | tail
```

Check:

- The module prints success messages
- A file appears under `/proc`, e.g. `/proc/mydriver_status`

List proc entries:

```bash
ls /proc/mydriver*
```

## Using the proc Entry

### Read

```bash
cat /proc/mydriver_status
```

This calls your `proc_read` function and returns the kernel data.

### Write

```bash
echo "test message" | sudo tee /proc/mydriver_status
```

This calls your `proc_write` function and logs the message via `pr_info()`.

Check kernel logs:

```bash
dmesg | tail
```

## Unloading the Module

```bash
sudo rmmod procfs_driver
dmesg | tail
```

Ensure the module:

- Removes all proc entries with `remove_proc_entry()` or `proc_remove()`
- Cleans up any allocated resources

## Example: Read-Only proc Entry

For a simple read-only entry:

```c
static struct proc_ops my_proc_ops = {
    .proc_read = my_proc_read,
};

struct proc_dir_entry *entry = proc_create(
    "mydriver_info",
    0444,  // read-only
    NULL,
    &my_proc_ops
);
```

User space can only read:

```bash
cat /proc/mydriver_info
```

## Prerequisites

- Linux system with kernel headers and build tools
- Basic C programming knowledge
- Familiarity with:
  - `make`, `gcc`
  - `insmod`, `rmmod`, `dmesg`
  - `/proc` filesystem

## Minimal Build Environment (Ubuntu)

```bash
sudo apt update
sudo apt install -y build-essential linux-headers-$(uname -r)
```

## Best Practices and Modern Alternatives

- For **device configuration and status**, prefer `sysfs` (`/sys`) over `procfs`
- Use `procfs` mainly for:
  - Debug output
  - Global kernel/runtime information
  - Learning and experimentation

Key differences:

| Aspect          | procfs (`/proc`)                  | sysfs (`/sys`)                      |
|-----------------|-----------------------------------|-------------------------------------|
| Purpose         | Kernel/process internals          | Device & driver attributes          |
| Structure       | Flat, unstructured                | Hierarchical, object-based          |
| Recommended for drivers | Legacy / debug only       | Production interfaces               |
| Example paths   | `/proc/cpuinfo`, `/proc/meminfo`  | `/sys/class/`, `/sys/devices/`      |

Reference: procfs vs sysfs for device drivers [web:22].



## Conslusion
This is just a basic linux device driver which explains about the procfs.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/procfs-in-linux/
