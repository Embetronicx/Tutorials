# Linux Device Driver - Tasklet (Static Method)

## Overview

A Tasklet is a Linux kernel **Bottom Half** mechanism used to defer interrupt-related work.

When an interrupt occurs:

```text
Hardware Interrupt
        |
        v
Interrupt Handler (Top Half)
        |
        v
Tasklet (Bottom Half)
        |
        v
Deferred Processing
```

Tasklets execute later with interrupts enabled and are designed for short deferred operations.

---

# Why Tasklets?

Interrupt handlers should execute as quickly as possible.

Bad ISR:

```text
Interrupt
   |
   +--> Long Processing
   +--> Computation
   +--> Buffer Handling
```

Good ISR:

```text
Interrupt
    |
    +--> Acknowledge Device
    +--> Schedule Tasklet
    +--> Return
```

The tasklet performs the deferred processing later.

---

# Linux Bottom Half Mechanisms

Linux provides four common Bottom Half mechanisms:

| Mechanism    | Context         | Sleep Allowed |
| ------------ | --------------- | ------------- |
| Workqueue    | Process Context | Yes           |
| Threaded IRQ | Process Context | Yes           |
| SoftIRQ      | Atomic Context  | No            |
| Tasklet      | Atomic Context  | No            |

Tasklets are implemented on top of SoftIRQs.

---

# Important Characteristics

## Atomic Context

Tasklets run in atomic context.

Not Allowed:

```c
msleep();
schedule();
mutex_lock();
down();
wait_event();
```

Allowed:

```c
spin_lock();
spin_unlock();
```

Tasklets cannot block or sleep.

---

## CPU Affinity

A tasklet runs only on the CPU that scheduled it.

```text
CPU0
  |
  +--> tasklet_schedule()
           |
           +--> Tasklet executes on CPU0
```

This improves cache locality.

---

## No Self-Concurrency

The same tasklet cannot run simultaneously on multiple CPUs.

```text
Tasklet X

CPU0 --> Running

CPU1 --> Cannot Run Same Tasklet
```

However:

```text
Tasklet A --> CPU0

Tasklet B --> CPU1
```

Different tasklets may execute in parallel.

---

# Tasklet Structure

Header:

```c
#include <linux/interrupt.h>
```

Kernel structure:

```c
struct tasklet_struct
{
    struct tasklet_struct *next;
    unsigned long state;
    atomic_t count;
    void (*func)(unsigned long);
    unsigned long data;
};
```

Field Description:

| Field | Purpose                     |
| ----- | --------------------------- |
| next  | Next tasklet                |
| state | Scheduled / Running         |
| count | Disable count               |
| func  | Callback function           |
| data  | Argument passed to callback |

---

# Creating Tasklet (Static Method)

## DECLARE_TASKLET()

Creates and initializes a tasklet.

Syntax:

```c
DECLARE_TASKLET(
        name,
        function,
        data);
```

Example:

```c
void tasklet_fn(unsigned long);

DECLARE_TASKLET(
        tasklet,
        tasklet_fn,
        1);
```

Equivalent Concept:

```c
struct tasklet_struct tasklet =
{
    NULL,
    0,
    0,
    tasklet_fn,
    1
};
```

The tasklet is initially enabled.

---

# Creating Disabled Tasklet

## DECLARE_TASKLET_DISABLED()

Creates tasklet in disabled state.

```c
DECLARE_TASKLET_DISABLED(
        tasklet,
        tasklet_fn,
        1);
```

Enable later:

```c
tasklet_enable(&tasklet);
```

---

# Tasklet Callback Function

The deferred work executes here.

```c
void tasklet_fn(
        unsigned long arg)
{
    printk(
      KERN_INFO,
      "Executing Tasklet : %ld\n",
      arg);
}
```

Parameter:

```c
unsigned long arg
```

Receives the value specified during creation.

---

# Enable Tasklet

```c
tasklet_enable(
        &tasklet);
```

Enables execution.

---

# Disable Tasklet

## tasklet_disable()

Waits for completion.

```c
tasklet_disable(
        &tasklet);
```

---

## tasklet_disable_nosync()

Disables immediately.

```c
tasklet_disable_nosync(
        &tasklet);
```

Does not wait for currently running execution.

---

# Scheduling Tasklets

## tasklet_schedule()

Schedules tasklet with normal priority.

```c
tasklet_schedule(
        &tasklet);
```

Example:

```c
tasklet_schedule(
        &tasklet);
```

If already pending:

```text
Request Ignored
```

The tasklet is not queued twice.

---

# High Priority Tasklet

## tasklet_hi_schedule()

```c
tasklet_hi_schedule(
        &tasklet);
```

Schedules tasklet with high priority.

---

## tasklet_hi_schedule_first()

```c
tasklet_hi_schedule_first(
        &tasklet);
```

Special-purpose API rarely used in drivers.

---

# Tasklet Queues

Each CPU maintains:

```text
CPU0
 |
 +--> Normal Queue
 |
 +--> High Priority Queue

CPU1
 |
 +--> Normal Queue
 |
 +--> High Priority Queue
```

Tasklets are inserted into one of these queues.

---

# Interrupt + Tasklet Example

## Tasklet Declaration

```c
void tasklet_fn(unsigned long);

DECLARE_TASKLET(
        tasklet,
        tasklet_fn,
        1);
```

---

## ISR

```c
static irqreturn_t irq_handler(
        int irq,
        void *dev_id)
{
    printk(
      KERN_INFO,
      "Interrupt Occurred\n");

    tasklet_schedule(
            &tasklet);

    return IRQ_HANDLED;
}
```

ISR only schedules the tasklet.

---

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

# Execution Flow

```text
Interrupt
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
Tasklet Function
```

---

# Killing Tasklet

## tasklet_kill()

Waits for completion and removes tasklet.

```c
tasklet_kill(
        &tasklet);
```

Driver cleanup:

```c
static void __exit driver_exit(void)
{
    tasklet_kill(&tasklet);

    free_irq(
            IRQ_NO,
            dev_id);
}
```

Always call before unloading the module.

---

# Sample dmesg Output

```text
Device Driver Insert...Done!!!

Read function

Shared IRQ: Interrupt Occurred

Executing Tasklet Function : arg = 1

Device Driver Remove...Done!!!
```

This verifies:

1. Interrupt triggered
2. ISR executed
3. Tasklet scheduled
4. Tasklet callback executed

---

# Tasklet vs Workqueue

| Feature          | Tasklet | Workqueue |
| ---------------- | ------- | --------- |
| Context          | Atomic  | Process   |
| Sleep Allowed    | No      | Yes       |
| Mutex Allowed    | No      | Yes       |
| Uses kworker     | No      | Yes       |
| Long Processing  | No      | Yes       |
| Spinlock Allowed | Yes     | Yes       |

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
      +--> Packet Handling
```

---

## GPIO Driver

```text
Button Interrupt
      |
      +--> Event Processing
```

---

## SPI Driver

```text
Transfer Complete
        |
        +--> Deferred Processing
```

---

# Best Practices

* Keep ISR extremely short.
* Use tasklets only for short deferred work.
* Never sleep inside tasklets.
* Use spinlocks instead of mutexes.
* Kill tasklets before unloading driver.
* Use workqueues when sleeping is required.

---

# Important APIs Summary

## Creation

```c
DECLARE_TASKLET()
DECLARE_TASKLET_DISABLED()
```

## Control

```c
tasklet_enable()
tasklet_disable()
tasklet_disable_nosync()
```

## Scheduling

```c
tasklet_schedule()
tasklet_hi_schedule()
tasklet_hi_schedule_first()
```

## Removal

```c
tasklet_kill()
tasklet_kill_immediate()
```

---

# Key Takeaways

* Tasklets are Bottom Half mechanisms built on SoftIRQs.
* Tasklets execute in atomic context.
* Tasklets cannot sleep or block.
* Same tasklet never runs concurrently on multiple CPUs.
* ISR commonly schedules tasklets for deferred work.
* Tasklets are lighter than workqueues but more restricted.
* Use workqueues whenever deferred work requires sleeping or blocking operations.


## Conclusion
This is just a basic linux device driver. This will explain taklet static method in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/tasklet-static-method/
