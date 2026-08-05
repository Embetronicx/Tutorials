# Linux Device Driver - Tasklet (Dynamic Method)

## Overview

This tutorial demonstrates **dynamic creation and initialization of Tasklets** using `tasklet_init()`.

Unlike the static method:

```c
DECLARE_TASKLET(tasklet, tasklet_fn, 1);
```

the dynamic method allocates memory for the tasklet at runtime and initializes it later.

---

# Static vs Dynamic Tasklet

## Static Method

```c
DECLARE_TASKLET(
        tasklet,
        tasklet_fn,
        1);
```

* Compile-time initialization
* Fixed declaration
* Simpler implementation

---

## Dynamic Method

```c
struct tasklet_struct *tasklet;

tasklet = kmalloc(
            sizeof(struct tasklet_struct),
            GFP_KERNEL);

tasklet_init(
        tasklet,
        tasklet_fn,
        0);
```

* Runtime initialization
* Flexible allocation
* Useful when tasklets are embedded in dynamically allocated structures

---

# Why Dynamic Tasklets?

Dynamic initialization is useful when:

* Number of tasklets is unknown at compile time
* Driver allocates resources dynamically
* Tasklets are associated with dynamically created devices
* Tasklet lifetime depends on runtime events

Example:

```text
Device Detected
      |
      v
Allocate Memory
      |
      v
Create Tasklet
      |
      v
Use Tasklet
      |
      v
Free Tasklet
```

---

# Tasklet Architecture

```text
Hardware Interrupt
        |
        v
Interrupt Handler
        |
        v
tasklet_schedule()
        |
        v
Tasklet Queue
        |
        v
Tasklet Function
```

The ISR schedules the tasklet and exits quickly. The actual processing happens later.

---

# Required Header Files

```c
#include <linux/interrupt.h>
#include <linux/slab.h>
```

Needed for:

* tasklet APIs
* kmalloc()
* kfree()

---

# Dynamic Tasklet Declaration

Pointer declaration:

```c
struct tasklet_struct *tasklet;
```

Initially:

```c
tasklet = NULL;
```

---

# Memory Allocation

Allocate tasklet structure dynamically:

```c
tasklet =
    kmalloc(
        sizeof(struct tasklet_struct),
        GFP_KERNEL);
```

Validation:

```c
if(tasklet == NULL)
{
    printk(
      KERN_INFO
      "Cannot allocate memory");
}
```

---

# Dynamic Initialization

## tasklet_init()

Initializes the dynamically allocated tasklet.

Syntax:

```c
void tasklet_init(
        struct tasklet_struct *t,
        void (*func)(unsigned long),
        unsigned long data);
```

Parameters:

| Parameter | Description                 |
| --------- | --------------------------- |
| t         | Tasklet structure           |
| func      | Callback function           |
| data      | Argument passed to callback |

Example:

```c
tasklet_init(
        tasklet,
        tasklet_fn,
        0);
```

---

# What tasklet_init() Does Internally

Conceptually:

```c
tasklet->func  = tasklet_fn;

tasklet->data  = 0;

tasklet->state = TASKLET_STATE_SCHED;

atomic_set(
        &tasklet->count,
        0);
```

This:

* Assigns callback function
* Stores argument
* Initializes tasklet state
* Enables tasklet

---

# Tasklet Callback Function

Executed when tasklet runs.

```c
void tasklet_fn(
        unsigned long arg)
{
    printk(
      KERN_INFO
      "Executing Tasklet Function : arg=%ld\n",
      arg);
}
```

Parameter:

```c
unsigned long arg
```

Receives the value passed through `tasklet_init()`.

---

# Scheduling Tasklet

## tasklet_schedule()

Schedules tasklet for execution.

```c
tasklet_schedule(
        tasklet);
```

Execution:

```text
ISR
 |
 +--> tasklet_schedule()
 |
 +--> Return

Later...

Tasklet Function Executes
```

---

# Interrupt + Dynamic Tasklet Example

## Tasklet Function

```c
void tasklet_fn(
        unsigned long arg)
{
    printk(
      KERN_INFO,
      "Executing Tasklet Function : arg=%ld\n",
      arg);
}
```

---

## Interrupt Handler

```c
static irqreturn_t irq_handler(
        int irq,
        void *dev_id)
{
    printk(
      KERN_INFO,
      "Shared IRQ: Interrupt Occurred");

    tasklet_schedule(
            tasklet);

    return IRQ_HANDLED;
}
```

ISR schedules the tasklet and exits immediately.

---

# Driver Initialization

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

## Allocate Tasklet

```c
tasklet =
    kmalloc(
        sizeof(struct tasklet_struct),
        GFP_KERNEL);
```

---

## Initialize Tasklet

```c
tasklet_init(
        tasklet,
        tasklet_fn,
        0);
```

Driver is now ready to schedule tasklets.

---

# Execution Flow

```text
insmod driver.ko
        |
        v
kmalloc()
        |
        v
tasklet_init()
        |
        v
Interrupt Occurs
        |
        v
ISR
        |
        v
tasklet_schedule()
        |
        v
Tasklet Queue
        |
        v
tasklet_fn()
```

---

# Driver Cleanup

Before unloading:

```c
tasklet_kill(
        tasklet);
```

Release memory:

```c
kfree(tasklet);
```

Complete cleanup:

```c
tasklet_kill(tasklet);

if(tasklet != NULL)
{
    kfree(tasklet);
}
```

Always kill the tasklet before freeing memory.

---

# Sample dmesg Output

After:

```bash
cat /dev/etx_device
```

Output:

```text
Device File Opened...!!!

Read function

Shared IRQ: Interrupt Occurred

Executing Tasklet Function : arg = 0

Device File Closed...!!!
```

This confirms:

1. Interrupt occurred
2. ISR executed
3. Tasklet scheduled
4. Tasklet callback executed

---

# Dynamic vs Static Tasklet

| Feature           | Static Method     | Dynamic Method    |
| ----------------- | ----------------- | ----------------- |
| Initialization    | DECLARE_TASKLET() | tasklet_init()    |
| Allocation        | Compile Time      | Runtime           |
| Memory Management | Automatic         | kmalloc()/kfree() |
| Flexibility       | Low               | High              |
| Runtime Creation  | No                | Yes               |

---

# Dynamic Tasklet vs Workqueue

| Feature         | Dynamic Tasklet | Workqueue |
| --------------- | --------------- | --------- |
| Context         | Atomic          | Process   |
| Sleep Allowed   | No              | Yes       |
| Mutex Allowed   | No              | Yes       |
| Uses kworker    | No              | Yes       |
| Deferred Work   | Yes             | Yes       |
| Long Processing | No              | Yes       |

---

# Common Driver Use Cases

## UART Driver

```text
RX Interrupt
     |
     +--> Tasklet
     |
     +--> Buffer Processing
```

---

## Network Driver

```text
Packet Arrival
      |
      +--> Tasklet
      |
      +--> Protocol Processing
```

---

## SPI Driver

```text
Transfer Complete
        |
        +--> Deferred Handling
```

---

## GPIO Driver

```text
Button Interrupt
        |
        +--> Event Processing
```

---

# Best Practices

* Keep ISR extremely short.
* Schedule tasklet from ISR.
* Never sleep inside tasklet.
* Use spinlocks if synchronization is required.
* Always call `tasklet_kill()` before freeing memory.
* Use workqueues instead when sleeping or blocking is required.

---

# Important APIs Summary

## Memory Management

```c
kmalloc()
kfree()
```

---

## Initialization

```c
tasklet_init()
```

---

## Scheduling

```c
tasklet_schedule()
tasklet_hi_schedule()
tasklet_hi_schedule_first()
```

---

## Control

```c
tasklet_enable()
tasklet_disable()
tasklet_disable_nosync()
```

---

## Cleanup

```c
tasklet_kill()
tasklet_kill_immediate()
```

---

# Key Takeaways

* Dynamic tasklets are created using `tasklet_init()`.
* Memory is allocated using `kmalloc()`.
* ISR schedules tasklets using `tasklet_schedule()`.
* Tasklets execute in atomic context.
* Tasklets cannot sleep or block.
* `tasklet_kill()` must be called before freeing tasklet memory.
* Dynamic tasklets provide greater flexibility than static tasklets.
* Use dynamic tasklets when tasklet lifetime depends on runtime allocation.

## Conclusion
This is just a basic linux device driver. This will explain tasklet dynamic method in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/tasklets-dynamic-method/
