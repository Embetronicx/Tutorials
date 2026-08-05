# Linux Device Driver - Own Workqueue (Dedicated Workqueue)

## Overview

In previous Workqueue examples, work items were queued to the **kernel global workqueue** using:

```c
schedule_work(&work);
```

In this tutorial, we create a **dedicated workqueue** for the driver and queue work to it using:

```c
queue_work(own_workqueue, &work);
```

This provides better isolation and control over deferred processing.

---

# Global Workqueue vs Own Workqueue

## Global Workqueue

```text
Driver
   |
   v
schedule_work()
   |
   v
Kernel Global Workqueue
   |
   v
kworker Thread
```

Characteristics:

* Shared by many kernel subsystems
* No creation required
* Easy to use
* Less control

---

## Own Workqueue

```text
Driver
   |
   v
queue_work()
   |
   v
Own Workqueue
   |
   v
Dedicated Worker Thread
```

Characteristics:

* Driver-specific workqueue
* Better isolation
* More control
* Suitable for heavy workloads

---

# Workqueue Components

## Workqueue Structure

Represents the workqueue itself.

```c
struct workqueue_struct *own_workqueue;
```

---

## Work Structure

Represents a deferred work item.

```c
struct work_struct work;
```

Usually initialized as:

```c
DECLARE_WORK(work, workqueue_fn);
```

---

# Header File

```c
#include <linux/workqueue.h>
```

Required for:

* work_struct
* workqueue_struct
* queue_work()
* create_workqueue()

---

# Creating a Workqueue

## create_workqueue()

Creates a dedicated workqueue.

```c
struct workqueue_struct *
create_workqueue(const char *name);
```

Example:

```c
own_workqueue =
        create_workqueue("own_wq");
```

Creates:

```text
own_wq
```

workqueue for this driver.

---

# Single Thread Workqueue

## create_singlethread_workqueue()

Creates a workqueue with only one worker thread.

```c
own_workqueue =
create_singlethread_workqueue(
        "own_wq");
```

Useful when:

* Work items must execute sequentially
* Parallel execution is not desired

---

# Internal Implementation

Both macros use:

```c
alloc_workqueue()
```

internally.

```c
create_workqueue()
    |
    v
alloc_workqueue()
```

---

# alloc_workqueue()

Low-level API.

```c
alloc_workqueue(
        fmt,
        flags,
        max_active);
```

Parameters:

| Parameter  | Description               |
| ---------- | ------------------------- |
| fmt        | Name format               |
| flags      | Workqueue flags           |
| max_active | Maximum active work items |

---

# Common Workqueue Flags

## WQ_UNBOUND

Workers are not tied to specific CPUs.

```c
WQ_UNBOUND
```

Benefits:

* Better scheduling flexibility
* Less CPU locality

---

## WQ_MEM_RECLAIM

Ensures forward progress during memory pressure.

```c
WQ_MEM_RECLAIM
```

Used by many kernel workqueues.

---

# Creating Work

Work item:

```c
static void workqueue_fn(
        struct work_struct *work);

static DECLARE_WORK(
        work,
        workqueue_fn);
```

---

# Workqueue Callback

Executed by worker thread.

```c
static void workqueue_fn(
        struct work_struct *work)
{
    printk(
      KERN_INFO
      "Executing Workqueue Function\n");
}
```

This function performs deferred processing.

---

# Queueing Work

## queue_work()

Queues work into the dedicated workqueue.

Syntax:

```c
bool queue_work(
        struct workqueue_struct *wq,
        struct work_struct *work);
```

Example:

```c
queue_work(
        own_workqueue,
        &work);
```

Returns:

| Value | Meaning             |
| ----- | ------------------- |
| false | Already queued      |
| true  | Successfully queued |

---

# Queue Work On Specific CPU

## queue_work_on()

```c
queue_work_on(
        cpu,
        own_workqueue,
        &work);
```

Example:

```c
queue_work_on(
        0,
        own_workqueue,
        &work);
```

Queues work on CPU0.

---

# Delayed Work

## queue_delayed_work()

Schedule after delay.

```c
queue_delayed_work(
        own_workqueue,
        &dwork,
        delay);
```

Example:

```c
queue_delayed_work(
        own_workqueue,
        &dwork,
        msecs_to_jiffies(5000));
```

Runs after 5 seconds.

---

# Delayed Work On Specific CPU

## queue_delayed_work_on()

```c
queue_delayed_work_on(
        cpu,
        own_workqueue,
        &dwork,
        delay);
```

Example:

```c
queue_delayed_work_on(
        0,
        own_workqueue,
        &dwork,
        delay);
```

---

# Interrupt + Own Workqueue Example

## Interrupt Handler

```c
static irqreturn_t irq_handler(
        int irq,
        void *dev_id)
{
    printk(
      KERN_INFO
      "Shared IRQ: Interrupt Occurred\n");

    queue_work(
            own_workqueue,
            &work);

    return IRQ_HANDLED;
}
```

ISR only schedules work and returns immediately.

---

# Driver Initialization

## Create Workqueue

```c
own_workqueue =
        create_workqueue(
                "own_wq");
```

---

## Register IRQ

```c
request_irq(
        IRQ_NO,
        irq_handler,
        IRQF_SHARED,
        "etx_device",
        (void *)irq_handler);
```

---

## Work Initialization

```c
DECLARE_WORK(
        work,
        workqueue_fn);
```

---

# Execution Flow

```text
Driver Loaded
      |
      v
Create own_wq
      |
      v
Interrupt Occurs
      |
      v
ISR Executes
      |
      v
queue_work()
      |
      v
own_wq
      |
      v
Worker Thread
      |
      v
workqueue_fn()
```

---

# Driver Cleanup

Always destroy the workqueue.

```c
destroy_workqueue(
        own_workqueue);
```

Complete cleanup:

```c
destroy_workqueue(
        own_workqueue);

free_irq(
        IRQ_NO,
        dev_id);
```

---

# Sample dmesg Output

```text
Device Driver Insert...Done!!!

Read function

Shared IRQ: Interrupt Occurred

Executing Workqueue Function

Device Driver Remove...Done!!!
```

This confirms:

1. Interrupt occurred
2. ISR executed
3. Work queued
4. Worker thread executed callback

---

# schedule_work() vs queue_work()

| Feature            | schedule_work() | queue_work() |
| ------------------ | --------------- | ------------ |
| Workqueue Used     | Global          | Custom       |
| Workqueue Creation | Not Required    | Required     |
| Control            | Limited         | More Control |
| Isolation          | Shared          | Dedicated    |
| API                | schedule_work() | queue_work() |

---

# Global Workqueue vs Own Workqueue

| Feature          | Global Workqueue | Own Workqueue                     |
| ---------------- | ---------------- | --------------------------------- |
| Setup Complexity | Simple           | Moderate                          |
| Dedicated Thread | No               | Yes                               |
| Isolation        | Shared           | Dedicated                         |
| Scalability      | Good             | Better for heavy driver workloads |
| Control          | Limited          | High                              |

---

# Real Driver Use Cases

## Network Driver

```text
Packet Arrival
      |
      v
ISR
      |
      v
Dedicated Packet Processing Workqueue
```

---

## SPI Driver

```text
Transfer Complete
       |
       v
Own Workqueue
       |
       v
Post Processing
```

---

## USB Driver

```text
USB Event
    |
    v
Own Workqueue
    |
    v
Protocol Handling
```

---

## Storage Driver

```text
DMA Completion
       |
       v
Dedicated Workqueue
       |
       v
Data Processing
```

---

# Advantages

* Driver-specific execution context
* Better workload isolation
* Prevents blocking global workqueue
* Greater scheduling control
* Suitable for heavy deferred processing

---

# Limitations

* Additional worker threads
* More memory usage
* More management overhead

---

# Important APIs Summary

## Workqueue Creation

```c
create_workqueue()
create_singlethread_workqueue()
alloc_workqueue()
```

---

## Queue Operations

```c
queue_work()
queue_work_on()
queue_delayed_work()
queue_delayed_work_on()
```

---

## Cleanup

```c
destroy_workqueue()
```

---

## Work Initialization

```c
DECLARE_WORK()
INIT_WORK()
```

---

# Key Takeaways

* Own Workqueue provides a dedicated execution context for a driver.
* `queue_work()` is used with custom workqueues.
* `schedule_work()` uses the kernel global workqueue.
* Workqueues execute in process context and can sleep.
* Dedicated workqueues are preferred for heavy or isolated deferred processing.
* Always destroy custom workqueues during module removal.
* Workqueues are commonly used with interrupts to move lengthy processing out of the ISR.


## Conclusion
This is just a basic linux device driver. This will explain about the Own workqueue in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/work-queue-in-linux-own-workqueue/
