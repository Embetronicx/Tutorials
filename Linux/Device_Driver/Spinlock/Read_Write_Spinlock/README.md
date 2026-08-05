# Linux Device Driver - Read-Write Spinlock in Linux Kernel (Spinlock Part 2)

## Overview

A Read-Write Spinlock (`rwlock_t`) is an extension of a normal spinlock that differentiates between:

* Readers
* Writers

Unlike a normal spinlock where only one thread can enter the critical section, a Read-Write Spinlock allows:

```text
Multiple Readers
        OR
Single Writer
```

This improves performance in read-heavy workloads.

---

# Why Read-Write Spinlock?

Consider a shared variable:

```c
unsigned long counter;
```

Access Pattern:

```text
Thread1 -> Read
Thread2 -> Read
Thread3 -> Read
Thread4 -> Read
Thread5 -> Write
```

With a normal spinlock:

```text
Reader1
   |
   +--> Lock

Reader2
   |
   +--> Wait

Reader3
   |
   +--> Wait
```

All readers serialize unnecessarily.

With Read-Write Spinlock:

```text
Reader1
Reader2
Reader3
Reader4
    |
    +--> Run Together
```

Only writers require exclusive access.

---

# What Problem Does It Solve?

Normal Spinlock:

```text
One Reader Allowed
```

Read-Write Spinlock:

```text
Many Readers Allowed
One Writer Allowed
```

Suitable when:

```text
Reads  >>>  Writes
```

Examples:

* Statistics counters
* Configuration tables
* Routing tables
* Driver status structures
* Lookup tables

---

# Working Principle

## Case 1: No Lock Holder

```text
Critical Section Empty

Reader  -> Allowed
Writer  -> Allowed
```

---

## Case 2: Reader Holds Lock

```text
Reader1 Running
```

New Reader:

```text
Reader2 -> Allowed
Reader3 -> Allowed
Reader4 -> Allowed
```

Writer:

```text
Writer -> Must Wait
```

---

## Case 3: Writer Holds Lock

```text
Writer Running
```

Then:

```text
Reader -> Blocked
Writer -> Blocked
```

No other thread can enter.

---

# Reader Preference

Read-Write Spinlock favors readers.

Example:

```text
Reader1 enters
Reader2 enters
Reader3 enters

Writer waiting
```

While writer is waiting:

```text
Reader4 enters
Reader5 enters
Reader6 enters
```

Writer continues waiting until all readers leave.

This can cause:

```text
Writer Starvation
```

For writer-priority workloads, Linux provides:

```text
Seqlock
```

instead.

---

# When To Use?

Use Read Lock:

```text
Only Reading Data
```

Use Write Lock:

```text
Modifying Data
```

Ideal when:

```text
90% Reads
10% Writes
```

Not useful when:

```text
Frequent Writes
```

because writers block everyone.

---

# Header File

```c
#include <linux/spinlock.h>
```

---

# Data Type

```c
rwlock_t etx_rwlock;
```

Represents a Read-Write Spinlock.

---

# Initialization

## Static Method

```c
DEFINE_RWLOCK(etx_rwlock);
```

Creates and initializes lock.

Example:

```c
static DEFINE_RWLOCK(etx_rwlock);
```

---

## Dynamic Method

Declaration:

```c
rwlock_t etx_rwlock;
```

Initialization:

```c
rwlock_init(&etx_rwlock);
```

Used when runtime initialization is required.

---

# Approach 1 - User Context Locking

Used between:

```text
Kernel Thread
       ↔
Kernel Thread
```

---

# Read Lock APIs

## read_lock()

Acquire reader lock.

```c
read_lock(
        &etx_rwlock);
```

Behavior:

```text
No Writer Present
      |
      +--> Enter

Writer Present
      |
      +--> Spin
```

---

## read_unlock()

Release reader lock.

```c
read_unlock(
        &etx_rwlock);
```

---

# Write Lock APIs

## write_lock()

Acquire writer lock.

```c
write_lock(
        &etx_rwlock);
```

Behavior:

```text
No Readers
No Writers
      |
      +--> Enter

Otherwise
      |
      +--> Spin
```

---

## write_unlock()

Release writer lock.

```c
write_unlock(
        &etx_rwlock);
```

---

# Example - Reader/Writer Threads

## Writer Thread

```c
int thread_function1(
        void *pv)
{
    while(
      !kthread_should_stop())
    {
        write_lock(
            &etx_rwlock);

        etx_global_variable++;

        write_unlock(
            &etx_rwlock);

        msleep(1000);
    }

    return 0;
}
```

---

## Reader Thread

```c
int thread_function2(
        void *pv)
{
    while(
      !kthread_should_stop())
    {
        read_lock(
            &etx_rwlock);

        printk(
            "Value=%lu\n",
            etx_global_variable);

        read_unlock(
            &etx_rwlock);

        msleep(1000);
    }

    return 0;
}
```

---

# Approach 2 - Between Bottom Halves

Used between:

```text
Tasklet ↔ Tasklet

SoftIRQ ↔ SoftIRQ
```

Use:

```c
read_lock()
write_lock()
```

and corresponding unlock APIs.

---

# Approach 3 - User Context + Bottom Half

Used between:

```text
Kernel Thread
      ↔
Tasklet

Kernel Thread
      ↔
SoftIRQ
```

---

## Read Lock

```c
read_lock_bh(
        &etx_rwlock);
```

---

## Read Unlock

```c
read_unlock_bh(
        &etx_rwlock);
```

---

## Write Lock

```c
write_lock_bh(
        &etx_rwlock);
```

---

## Write Unlock

```c
write_unlock_bh(
        &etx_rwlock);
```

What `_bh` does:

```text
Disable SoftIRQ
Acquire Lock
```

Unlock:

```text
Release Lock
Enable SoftIRQ
```

---

# Approach 4 - Hard IRQ + Bottom Half

Used between:

```text
ISR
  ↔
Tasklet

ISR
  ↔
SoftIRQ
```

---

## Read Lock

```c
read_lock_irq(
        &etx_rwlock);
```

---

## Read Unlock

```c
read_unlock_irq(
        &etx_rwlock);
```

---

## Write Lock

```c
write_lock_irq(
        &etx_rwlock);
```

---

## Write Unlock

```c
write_unlock_irq(
        &etx_rwlock);
```

These APIs:

```text
Disable Local Interrupts
Acquire Lock
```

Then:

```text
Release Lock
Enable Interrupts
```

---

# Approach 5 - IRQ Save/Restore Variant

Preferred in many drivers.

---

## Read Side

```c
unsigned long flags;

read_lock_irqsave(
        &etx_rwlock,
        flags);

...

read_unlock_irqrestore(
        &etx_rwlock,
        flags);
```

---

## Write Side

```c
unsigned long flags;

write_lock_irqsave(
        &etx_rwlock,
        flags);

...

write_unlock_irqrestore(
        &etx_rwlock,
        flags);
```

Advantage:

```text
Restores Previous IRQ State
```

instead of blindly enabling interrupts.

---

# Execution Example

```text
Reader1
   |
   +--> read_lock()

Reader2
   |
   +--> read_lock()

Reader3
   |
   +--> read_lock()
```

All three execute simultaneously.

Writer:

```text
Writer
   |
   +--> write_lock()
   |
   +--> Waiting
```

After all readers exit:

```text
Writer Acquires Lock
```

---

# Read-Write Spinlock vs Spinlock

| Feature              | Spinlock | RW Spinlock |
| -------------------- | -------- | ----------- |
| Readers              | 1        | Multiple    |
| Writers              | 1        | 1           |
| Read Parallelism     | No       | Yes         |
| Write Parallelism    | No       | No          |
| Read Heavy Workloads | Poor     | Excellent   |
| Complexity           | Simple   | Higher      |

---

# Read-Write Spinlock vs Mutex

| Feature               | RW Spinlock | Mutex |
| --------------------- | ----------- | ----- |
| Sleep Allowed         | No          | Yes   |
| Busy Wait             | Yes         | No    |
| IRQ Context           | Yes         | No    |
| Read Sharing          | Yes         | No    |
| Long Critical Section | No          | Yes   |

---

# Typical Driver Use Cases

## Statistics

```c
read_lock(&stats_lock);
packets = stats.rx_packets;
read_unlock(&stats_lock);
```

---

## Routing Table

```c
read_lock(&route_lock);
lookup_route();
read_unlock(&route_lock);
```

---

## Device State

```c
read_lock(&state_lock);
status = device_status;
read_unlock(&state_lock);
```

---

## Configuration Updates

```c
write_lock(&cfg_lock);
update_configuration();
write_unlock(&cfg_lock);
```

---

# Common Mistakes

## Sleeping Inside Lock

Wrong:

```c
read_lock(&lock);

msleep(100);

read_unlock(&lock);
```

RW Spinlocks cannot sleep.

---

## Using For Write-Heavy Workloads

Wrong choice:

```text
Writes >> Reads
```

Use normal spinlock or mutex instead.

---

## Long Critical Sections

Wrong:

```c
write_lock(&lock);

/* lengthy processing */

write_unlock(&lock);
```

Readers and writers remain blocked/spinning.

---

# Important APIs Summary

## Initialization

```c
DEFINE_RWLOCK()

rwlock_init()
```

---

## Reader

```c
read_lock()
read_unlock()

read_lock_bh()
read_unlock_bh()

read_lock_irq()
read_unlock_irq()

read_lock_irqsave()
read_unlock_irqrestore()
```

---

## Writer

```c
write_lock()
write_unlock()

write_lock_bh()
write_unlock_bh()

write_lock_irq()
write_unlock_irq()

write_lock_irqsave()
write_unlock_irqrestore()
```

---

# Key Takeaways

* Read-Write Spinlock allows **multiple concurrent readers** but only **one writer**.
* Readers can run simultaneously if no writer holds the lock.
* Writers require exclusive access.
* RW spinlocks are best for **read-heavy workloads**.
* RW spinlocks run in atomic context and cannot sleep.
* `_bh` variants protect against SoftIRQ/Tasklet interference.
* `_irq` variants disable interrupts while holding the lock.
* `_irqsave` variants are usually safest because they restore the previous interrupt state.
* RW spinlocks favor readers and can potentially starve writers.
* Use RW spinlocks only when read parallelism provides a measurable benefit.


## Conclusion
This is just a basic linux device driver. This will explain read write spinlock in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/read-write-spinlock/
