# Linux Device Driver - Kernel Thread (kthread)

## Overview

- A Kernel Thread (kthread) is a thread that runs entirely in kernel space and is managed by the Linux kernel scheduler.
- Unlike user-space threads, kernel threads do not belong to a user process and are typically used for background kernel activities, deferred processing, monitoring, and driver-specific tasks.

Common kernel threads visible on a Linux system include:

```bash
ps -eLf | grep kthread
```

Examples:

```text
kthreadd
kworker/*
rcu_tasks_kthread
migration/*
```

These are created and managed entirely by the kernel.

---

# Process vs Thread

## Process

A process is an executing instance of a program.

Characteristics:

* Separate address space
* Higher resource usage
* Expensive context switching

```text
Process A
  |
  +-- Memory
  +-- Files
  +-- Resources
```

## Thread

A thread is an execution path within a process.

Characteristics:

* Shares address space
* Lightweight
* Faster context switching

```text
Process
   |
   +--> Thread 1
   +--> Thread 2
   +--> Thread 3
```

Threads share memory and resources, making communication easier than between processes.

---

# Types of Threads

## User-Level Thread

Managed by user-space libraries.

Examples:

```text
POSIX Threads (pthread)
std::thread
Java Threads
```

Characteristics:

* User-space management
* Kernel unaware of thread implementation
* Faster creation

---

## Kernel-Level Thread

Managed directly by the kernel.

Characteristics:

* Scheduled by kernel
* Runs in kernel space
* Has access to kernel APIs
* Commonly used in device drivers

Examples:

```text
kworker
ksoftirqd
kthreadd
rcu_tasks_kthread
```

---

# Why Use Kernel Threads?

Kernel threads are useful when a driver needs:

* Continuous background processing
* Periodic monitoring
* Deferred work
* Polling hardware
* Watchdog functionality
* Data collection

Example:

```text
Temperature Sensor Driver
          |
          v
Kernel Thread
          |
          v
Read Temperature Every Second
```

---

# Kernel Thread Architecture

```text
Driver Init
      |
      v
Create kthread
      |
      v
Scheduler
      |
      v
Thread Function
      |
      v
Periodic Work
      |
      v
Stop Request
      |
      v
Thread Exit
```

---

# Required Header Files

```c
#include <linux/kthread.h>
#include <linux/sched.h>
#include <linux/delay.h>
```

---

# Thread Management APIs

## Create Thread

### kthread_create()

Creates a kernel thread but does not start it.

```c
struct task_struct *
kthread_create(
        int (*threadfn)(void *data),
        void *data,
        const char namefmt[],
        ...);
```

Parameters:

| Parameter | Description               |
| --------- | ------------------------- |
| threadfn  | Thread function           |
| data      | Argument passed to thread |
| namefmt   | Thread name               |

Returns:

```text
task_struct pointer
or
ERR_PTR(-ENOMEM)
```

---

# Start Thread

## wake_up_process()

Starts a thread created using `kthread_create()`.

```c
wake_up_process(
        etx_thread);
```

Example:

```c
etx_thread =
kthread_create(
        thread_function,
        NULL,
        "eTx Thread");

wake_up_process(
        etx_thread);
```

---

# Create and Start Together

## kthread_run()

Convenience wrapper around:

```text
kthread_create()
        +
wake_up_process()
```

Syntax:

```c
struct task_struct *
kthread_run(
        threadfn,
        data,
        namefmt,
        ...);
```

Example:

```c
etx_thread =
kthread_run(
        thread_function,
        NULL,
        "eTx Thread");
```

Preferred approach in modern drivers.

---

# Thread Function

Every kernel thread executes a function:

```c
int thread_function(
        void *data)
{
    return 0;
}
```

Requirements:

* Return integer
* Accept void pointer argument
* Should periodically check stop condition

---

# kthread_should_stop()

Checks whether thread termination was requested.

```c
while (!kthread_should_stop())
{
    // Thread work
}
```

Returns:

```text
0 -> Continue
1 -> Stop Requested
```

---

# Example Thread Function

```c
int thread_function(
        void *pv)
{
    int i = 0;

    while (!kthread_should_stop())
    {
        printk(
            KERN_INFO
            "Thread %d\n",
            i++);

        msleep(1000);
    }

    return 0;
}
```

Behavior:

```text
Print message
      |
      v
Sleep 1 second
      |
      v
Repeat
```

---

# Sleeping Inside Kernel Thread

Unlike ISR or Tasklet, kernel threads run in process context.

Allowed:

```c
msleep()
schedule()
wait_event()
mutex_lock()
```

Not allowed in:

```text
ISR
Tasklet
SoftIRQ
```

This is one major advantage of kernel threads.

---

# Stopping a Thread

## kthread_stop()

Stops a kernel thread.

```c
int kthread_stop(
        struct task_struct *k);
```

Example:

```c
kthread_stop(
        etx_thread);
```

What happens internally:

```text
Set stop flag
      |
      v
Wake thread
      |
      v
kthread_should_stop()
returns TRUE
      |
      v
Thread exits
```

---

# Thread Life Cycle

```text
Module Load
      |
      v
kthread_run()
      |
      v
Thread Running
      |
      v
while(!kthread_should_stop())
      |
      v
Periodic Work
      |
      v
kthread_stop()
      |
      v
Thread Exit
      |
      v
Module Unload
```

---

# CPU Affinity

## kthread_bind()

Bind thread to a specific CPU.

```c
kthread_bind(
        etx_thread,
        cpu);
```

Example:

```c
kthread_bind(
        etx_thread,
        0);
```

Runs only on CPU0.

Useful for:

* Real-time workloads
* CPU-specific processing
* Performance tuning

---

# Typical Driver Example

## Driver Init

```c
static struct task_struct *etx_thread;

etx_thread =
kthread_run(
        thread_function,
        NULL,
        "eTx Thread");
```

---

## Thread Function

```c
int thread_function(
        void *data)
{
    while(!kthread_should_stop())
    {
        printk("Running\n");

        msleep(1000);
    }

    return 0;
}
```

---

## Driver Exit

```c
kthread_stop(
        etx_thread);
```

---

# Execution Flow

```text
insmod driver.ko
        |
        v
kthread_run()
        |
        v
Thread Created
        |
        v
Thread Function
        |
        v
Loop
        |
        v
msleep()
        |
        v
Repeat
        |
        v
rmmod driver
        |
        v
kthread_stop()
        |
        v
Thread Exit
```

---

# Sample dmesg Output

```text
Device Driver Insert...Done!!!

Kthread Created Successfully...

In EmbeTronicX Thread Function 0

In EmbeTronicX Thread Function 1

In EmbeTronicX Thread Function 2

In EmbeTronicX Thread Function 3

Device Driver Remove...Done!!!
```

---

# Kernel Thread vs Workqueue

| Feature               | Kernel Thread | Workqueue                   |
| --------------------- | ------------- | --------------------------- |
| Dedicated Thread      | Yes           | No (usually shared kworker) |
| Continuous Loop       | Yes           | No                          |
| Can Sleep             | Yes           | Yes                         |
| Periodic Tasks        | Excellent     | Possible                    |
| Resource Usage        | Higher        | Lower                       |
| Background Monitoring | Excellent     | Limited                     |
| Scheduler Managed     | Yes           | Yes                         |

---

# Kernel Thread vs Tasklet

| Feature                 | Kernel Thread   | Tasklet        |
| ----------------------- | --------------- | -------------- |
| Context                 | Process Context | Atomic Context |
| Sleep Allowed           | Yes             | No             |
| Mutex Allowed           | Yes             | No             |
| wait_event()            | Yes             | No             |
| Long Processing         | Yes             | No             |
| Interrupt Deferred Work | Possible        | Yes            |

---

# Common Embedded Linux Use Cases

## Sensor Monitoring

```text
Kernel Thread
     |
     +--> Read Temperature
     +--> Read Voltage
     +--> Read Pressure
```

---

## Watchdog Driver

```text
Kernel Thread
      |
      +--> Feed Watchdog
      Every 1 Second
```

---

## UART Driver

```text
Kernel Thread
      |
      +--> Poll RX Buffer
      +--> Process Data
```

---

## Network Driver

```text
Kernel Thread
      |
      +--> Statistics Collection
      +--> Link Monitoring
```

---

# Best Practices

* Use `kthread_run()` instead of separate create/start calls.
* Always check `kthread_should_stop()`.
* Always stop thread during module unload.
* Avoid busy waiting.
* Use `msleep()` or wait queues when idle.
* Keep thread logic simple and predictable.
* Use workqueues if a dedicated thread is unnecessary.

---

# Important APIs Summary

## Creation

```c
kthread_create()
kthread_run()
```

## Start

```c
wake_up_process()
```

## Stop

```c
kthread_stop()
kthread_should_stop()
```

## CPU Affinity

```c
kthread_bind()
```

## Sleeping

```c
msleep()
schedule()
wait_event()
```

---

# Key Takeaways

* Kernel threads execute entirely in kernel space.
* They are represented by `struct task_struct`.
* `kthread_run()` is the most common way to create and start a thread.
* `kthread_should_stop()` must be checked in long-running loops.
* `kthread_stop()` is used during cleanup.
* Kernel threads run in process context and can sleep.
* They are ideal for periodic monitoring, polling, watchdogs, and background driver tasks.
* Kernel threads are heavier but more flexible than tasklets and workqueues.


## Conclusion
This is just a basic linux device driver which explains about the kernel thread in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/linux-device-drivers-tutorial-kernel-thread/
