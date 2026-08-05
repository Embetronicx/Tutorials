# Linux Device Driver – Part 1: Introduction
- This repository contains notes and example code for learning the basics of Linux device drivers, focusing on how drivers integrate with the Linux kernel and user space.

## What is a Device Driver?
- A device driver is a piece of software that lets the operating system communicate with hardware devices.  
- In Linux, many drivers are built into the kernel or loaded as kernel modules, allowing hardware to be
  controlled via standard interfaces.

## Types of Linux Device Drivers

Common categories of Linux device drivers include:

- **Character drivers** – Accessed as streams of bytes (for example `/dev/ttyS0` for serial ports)  
- **Block drivers** – Handle data in blocks and are used for storage devices  
- **Network drivers** – Interface network hardware with the kernel’s networking stack

This introduction usually starts with character drivers because they are simpler conceptually.

## Kernel Space vs User Space

Linux clearly separates:

- **User space** – Where normal applications run, with restricted access
- **Kernel space** – Where the kernel and drivers run, with full access to hardware and system resources

A device driver typically runs in kernel space and exposes an interface (often via `/dev` files or sysfs) that user-space programs can use.

## Loadable Kernel Modules (LKM)

Instead of compiling every driver into the kernel, Linux supports **loadable kernel modules**:

- Drivers can be compiled as modules
- Modules can be inserted (`insmod`/`modprobe`) and removed (`rmmod`) at runtime
- `dmesg` and `/var/log` can be used to inspect kernel messages from drivers

This introduction often walks through how to build a simple module, load it, and see messages using `dmesg`.

## Basic Steps to Write a Simple Driver Module

Typical steps you will follow in this series:

1. Write a minimal C file that defines `init` and `exit` functions for the module  
2. Use `module_init()` and `module_exit()` macros to register these functions  
3. Add a `Makefile` that uses the kernel build system to compile the module  
4. Build the module against your current kernel headers  
5. Load the module and verify its messages in the kernel log  
6. Unload the module cleanly

## Prerequisites

Before following along:

- Basic knowledge of C programming  
- A Linux environment (for example, Ubuntu) with kernel headers installed  
- Ability to use the terminal and run basic compilation commands

REFER: 
- https://github.com/darshankharbikar/raspberry-pi-4b
- https://embetronicx.com/tutorials/linux/device-drivers/setup-ubuntu-and-raspberry-pi-linux-device-driver-tutorial/
