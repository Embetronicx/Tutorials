# Linux Device Driver - Tasklet (Static Method)

## Overview

A Tasklet is a Linux kernel **Bottom Half** mechanism used to defer work from an Interrupt Service Routine (ISR).

When an interrupt occurs:

* ISR (Top Half) executes immediately.
* Time-consuming work is deferred to a Tasklet (Bottom Half).
* Tasklets run later with interrupts enabled.

Tasklets execute in **atomic context**, not process context. Therefore they cannot sleep or block.

---

# Why Tasklets?

Interrupt handlers should:

* Execute quickly
* Avoid lengthy processing
* Return control to the kernel as soon as possible

Tasklets allow deferred execution of non-critical interrupt-related work.

---

# Top Half vs Bottom Half

```text
Interrupt Occurs
        |
        v
+----------------+
| ISR (Top Half) |
+----------------+
        |
        v
Schedule Tasklet
        |
        v
+-------------------+
| Tasklet           |
| (Bottom Half)     |
+-------------------+
        |
        v
Deferred Processing
```

---

# Linux Bottom Half Mechanisms

Linux provides multiple Bottom Half mechanisms:

| Mechanism    | Context         | Sleep Allowed |
| ------------ | --------------- | ------------- |
| Workqueue    | Process Context | Yes           |
| Threaded IRQ | Process Context | Yes           |
| SoftIRQ      | Atomic Context  | No            |
| Tasklet      | Atomic Context  | No            |

Tasklets are built on top of SoftIRQs.

---

# Important Characteristics

## Tasklets are Atomic

Not allowed:

```c
sleep();
msleep();
mutex_lock();
down();
wait_event();
```

Allowed:

```c
spin_lock();
spin_unlock();
```

---

## CPU Affinity

A tasklet executes only on the CPU that scheduled it.

```text
CPU0 Schedules Tasklet
        |
        v
Tasklet Runs On CPU0
```

---

## No Self-Concurrency

A tasklet cannot execute simultaneously on multiple CPUs.

```text
Same Tasklet
    |
    +--> CPU0 (Running)

CPU1 Cannot Run Same Tasklet
Until CPU0 Completes
```

---

## Different Tasklets Can Run Concurrently

```text
Tasklet A --> CPU0

Tasklet B --> CPU1
```

Possible and supported.

---

# Tasklet Structure

Defined in:

```c
#include <linux/interrupt.h>
```

Structure:

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

| Field | Purpose                 |
| ----- | ----------------------- |
| next  | Next tasklet            |
| state | Running/Scheduled state |
| count | Disable counter         |
| func  | Callback function       |
| data  | Data passed to callback |

---

# Static Tasklet Creation

## DECLARE_TASKLET()

Creates and initializes a tasklet.

Syntax:

```c
DECLARE_TASKLET(
        name,
        function,
        data);
```

Parameters:

| Parameter | Description                 |
| --------- | --------------------------- |
| name      | Tasklet object              |
| function  | Callback function           |
| data      | Argument passed to callback |

Example:

```c
void tasklet_fn(unsigned long);

DECLARE_TASKLET(
        tasklet,
        tasklet_fn,
        1);
```

This tasklet is created in the enabled state.

---

# Disabled Tasklet Creation

## DECLARE_TASKLET_DISABLED()

Creates a disabled tasklet.

```c
DECLARE_TASKLET_DISABLED(
        tasklet,
        tasklet_fn,
        1);
```

Tasklet will not run until enabled.

```c
tasklet_enable(&tasklet);
```

---

# Tasklet Callback Function

This function performs deferred processing.

```c
void tasklet_fn(
        unsigned long arg)
{
    printk(
      "Executing Tasklet : %ld\n",
      arg);
}
```

Parameter:

```c
unsigned long arg
```

Receives the value passed during creation.

---

# Enable Tasklet

```c
tasklet_enable(
        &tasklet);
```

Enables execution of the tasklet.

---

# Disable Tasklet

## tasklet_disable()

Waits for running tasklet to finish.

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

Does not wait for completion.

---

# Schedule Tasklet

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

If already scheduled but not executed:

```text
New schedule request ignored
```

---

# High Priority Scheduling

## tasklet_hi_schedule()

Schedules tasklet with high priority.

```c
tasklet_hi_schedule(
        &tasklet);
```

---

## tasklet_hi_schedule_first()

Special version used in specific kernel scenarios.

```c
tasklet_hi_schedule_first(
        &tasklet);
```

---

# Tasklet Priorities

Linux supports:

```text
Normal Priority
High Priority
```

Each CPU maintains its own tasklet queues.

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

---

# Kill Tasklet

## tasklet_kill()

Waits for completion and removes tasklet.

```c
tasklet_kill(
        &tasklet);
```

Always call during module removal.

Example:

```c
tasklet_kill(
        &tasklet);
```

---

## tasklet_kill_immediate()

Used when CPU is dead/offline.

```c
tasklet_kill_immediate(
        &tasklet,
        cpu);
```

---

# Interrupt + Tasklet Example

## Tasklet Definition

```c
void tasklet_fn(
        unsigned long arg);

DECLARE_TASKLET(
        tasklet,
        tasklet_fn,
        1);
```

---

## Tasklet Function

```c
void tasklet_fn(
        unsigned long arg)
{
    printk(
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
      "Interrupt Occurred\n");

    tasklet_schedule(
            &tasklet);

    return IRQ_HANDLED;
}
```

ISR schedules the tasklet instead of performing lengthy processing.

---

# Execution Flow

```text
User Reads Device
        |
        v
Software Interrupt
        |
        v
IRQ Handler
        |
        v
tasklet_schedule()
        |
        v
Tasklet Queue
        |
        v
Tasklet Function Executes
```

---

# Driver Cleanup

During module unload:

```c
tasklet_kill(
        &tasklet);

free_irq(
        IRQ_NO,
        dev_id);
```

Tasklet must be killed before driver removal.

---

# Sample dmesg Output

```text
Major = 246 Minor = 0

Device Driver Insert...Done!!!

Device File Opened...!!!

Read function

Shared IRQ: Interrupt Occurred

Executing Tasklet Function : arg = 1

Device File Closed...!!!

Device Driver Remove...Done!!!
```

This confirms:

1. Interrupt occurred
2. ISR executed
3. Tasklet scheduled
4. Tasklet function executed

---

# Tasklet vs Workqueue

| Feature           | Tasklet | Workqueue |
| ----------------- | ------- | --------- |
| Context           | Atomic  | Process   |
| Sleep Allowed     | No      | Yes       |
| Uses kworker      | No      | Yes       |
| Can Block         | No      | Yes       |
| ISR Deferred Work | Yes     | Yes       |
| Mutex Allowed     | No      | Yes       |
| Spinlock Allowed  | Yes     | Yes       |

---

# Common Use Cases

## Network Driver

```text
Packet Arrival
     |
     +--> Tasklet Processing
```

---

## UART Driver

```text
RX Interrupt
      |
      +--> Buffer Processing
```

---

## SPI Driver

```text
Transfer Complete
        |
        +--> Deferred Processing
```

---

## GPIO Driver

```text
Button Interrupt
        |
        +--> Event Handling
```

---

# Best Practices

* Keep ISR extremely short.
* Schedule tasklets for deferred work.
* Never sleep inside tasklet.
* Use spinlocks instead of mutexes.
* Kill tasklets during driver cleanup.
* Use workqueues if sleeping is required.

---

# Important APIs Summary

## Creation

```c
DECLARE_TASKLET()
DECLARE_TASKLET_DISABLED()
```

---

## Control

```c
tasklet_enable()
tasklet_disable()
tasklet_disable_nosync()
```

---

## Scheduling

```c
tasklet_schedule()
tasklet_hi_schedule()
tasklet_hi_schedule_first()
```

---

## Removal

```c
tasklet_kill()
tasklet_kill_immediate()
```

---

# Key Takeaways

* Tasklets are Linux Bottom Half mechanisms.
* Tasklets execute in atomic context.
* Tasklets cannot sleep or block.
* Same tasklet cannot run concurrently on multiple CPUs.
* Different tasklets can execute in parallel.
* ISR commonly schedules a tasklet for deferred processing.
* Tasklets are lighter than workqueues but more restricted.
* Use workqueues when deferred work requires sleeping.

