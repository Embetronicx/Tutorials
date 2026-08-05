# Linux Device Driver - Workqueue (Dynamic Creation Method)

## Overview

This tutorial demonstrates **dynamic initialization of a Workqueue work item** using `INIT_WORK()`.

Unlike the static method:

```c
DECLARE_WORK(work, work_fn);
```

the dynamic method creates a `work_struct` object first and initializes it later using `INIT_WORK()`.

---

# Why Dynamic Workqueue?

Dynamic initialization is useful when:

* Work item is part of a structure
* Work item needs runtime initialization
* Driver requires flexible work creation
* Work object cannot be statically declared

Example:

```c
struct work_struct workqueue;

INIT_WORK(&workqueue, workqueue_fn);
```

---

# Workqueue Architecture

```text
Hardware Interrupt
        |
        v
Interrupt Handler (ISR)
        |
        v
schedule_work()
        |
        v
Kernel Global Workqueue
        |
        v
kworker Thread
        |
        v
workqueue_fn()
```

The ISR schedules work and returns immediately.

The actual processing happens later inside a kernel worker thread.

---

# Header File

```c
#include <linux/workqueue.h>
```

Required for:

* work_struct
* INIT_WORK()
* schedule_work()

---

# Workqueue Structure

```c
struct work_struct workqueue;
```

Represents a deferred work item.

Example:

```c
static struct work_struct workqueue;
```

---

# Dynamic Work Initialization

## INIT_WORK()

Used to initialize a work item.

Syntax:

```c
INIT_WORK(work, function);
```

Parameters:

| Parameter | Description        |
| --------- | ------------------ |
| work      | work_struct object |
| function  | Callback function  |

Example:

```c
INIT_WORK(
        &workqueue,
        workqueue_fn);
```

---

# Workqueue Callback Function

The callback executes inside a kernel worker thread.

```c
void workqueue_fn(
        struct work_struct *work)
{
    printk(KERN_INFO
           "Executing Workqueue Function\n");
}
```

This function performs the deferred processing.

---

# Scheduling Work

## schedule_work()

Queues work into the kernel global workqueue.

Syntax:

```c
int schedule_work(
        struct work_struct *work);
```

Example:

```c
schedule_work(&workqueue);
```

Return Value:

| Value    | Meaning             |
| -------- | ------------------- |
| 0        | Already queued      |
| Non-zero | Successfully queued |

---

# Delayed Scheduling

## schedule_delayed_work()

Execute after a delay.

Syntax:

```c
schedule_delayed_work(
        &dwork,
        delay);
```

Example:

```c
schedule_delayed_work(
        &dwork,
        msecs_to_jiffies(5000));
```

Executes after 5 seconds.

---

# CPU Specific Scheduling

## schedule_work_on()

Queues work on a specific CPU.

Syntax:

```c
schedule_work_on(
        cpu,
        &work);
```

Example:

```c
schedule_work_on(
        0,
        &workqueue);
```

Runs on CPU0.

---

# Interrupt + Workqueue Example

## Workqueue Function

```c
void workqueue_fn(
        struct work_struct *work)
{
    printk(
      KERN_INFO
      "Executing Workqueue Function\n");
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
      KERN_INFO
      "Shared IRQ: Interrupt Occurred\n");

    schedule_work(
            &workqueue);

    return IRQ_HANDLED;
}
```

ISR schedules work and exits immediately.

---

# Driver Initialization

## Register Interrupt

```c
request_irq(
        IRQ_NO,
        irq_handler,
        IRQF_SHARED,
        "etx_device",
        (void *)irq_handler);
```

---

## Create Work Dynamically

```c
INIT_WORK(
        &workqueue,
        workqueue_fn);
```

The work item is now ready for scheduling.

---

# Driver Execution Flow

```text
Driver Loaded
      |
      v
INIT_WORK()
      |
      v
Interrupt Occurs
      |
      v
IRQ Handler
      |
      v
schedule_work()
      |
      v
kworker Thread
      |
      v
workqueue_fn()
```

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

Executing Workqueue Function

Device File Closed...!!!
```

This confirms:

1. Interrupt occurred
2. ISR executed
3. Work scheduled
4. Workqueue function executed

---

# Build Driver

## Makefile

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

# Build and Test

Compile:

```bash
make
```

Load:

```bash
sudo insmod driver.ko
```

Trigger interrupt:

```bash
sudo cat /dev/etx_device
```

View logs:

```bash
dmesg
```

Unload:

```bash
sudo rmmod driver
```

---

# Dynamic vs Static Workqueue Initialization

| Static Method               | Dynamic Method                |
| --------------------------- | ----------------------------- |
| DECLARE_WORK()              | INIT_WORK()                   |
| Compile-time initialization | Runtime initialization        |
| Simpler                     | More flexible                 |
| Fixed declaration           | Can be embedded in structures |
| Less configurable           | More configurable             |

---

# Dynamic Workqueue vs Own Workqueue

| Dynamic Method        | Own Workqueue             |
| --------------------- | ------------------------- |
| Uses global workqueue | Uses dedicated workqueue  |
| Uses schedule_work()  | Uses queue_work()         |
| No worker creation    | Must create worker thread |
| Simpler               | Greater control           |
| Shared kworker thread | Dedicated worker thread   |

---

# Advantages

* Runtime initialization
* Flexible design
* Easy ISR integration
* No custom worker thread needed
* Uses kernel-managed kworker threads

---

# Limitations

* Uses shared global workqueue
* Heavy tasks may affect other queued work
* Less control than custom workqueues

---

# Important APIs Summary

## Initialization

```c
INIT_WORK()
```

---

## Scheduling

```c
schedule_work()
schedule_delayed_work()
schedule_work_on()
schedule_delayed_work_on()
```

---

## Work Structure

```c
struct work_struct
```

---

## Interrupt Related

```c
request_irq()
free_irq()
```

---

# Key Takeaways

* `INIT_WORK()` dynamically initializes a work item.
* `schedule_work()` places work on the kernel global workqueue.
* Work executes in a `kworker` thread, not in interrupt context.
* Workqueue functions can perform longer operations than ISRs.
* The ISR should only schedule work and return quickly.
* Dynamic initialization provides more flexibility than `DECLARE_WORK()`.
* This method still uses the kernel global workqueue; it does not create a dedicated workqueue.
