# Linux Device Driver - Seqlock in Linux Kernel

## Overview

A **Seqlock (Sequential Lock)** is a synchronization mechanism that gives **priority to writers** while allowing readers to read data without taking a traditional lock. It was introduced in Linux 2.5.60 to solve the writer-starvation problem that can occur with Read-Write Spinlocks. ([EmbeTronicX][1])

In simple terms:

```text
Spinlock
    |
    +--> Readers and Writers treated equally

RW Spinlock
    |
    +--> Readers favored

Seqlock
    |
    +--> Writers favored
```

---

# Why Seqlock?

Consider a system where:

```text
95% Reads
5% Writes
```

Using a RW Spinlock:

```text
Reader1
Reader2
Reader3
Reader4
Reader5
      |
      +--> Writer Waiting
```

New readers can continue entering, causing:

```text
Writer Starvation
```

Seqlock solves this by allowing writers to proceed while readers retry if a write occurs during their read. ([EmbeTronicX][1])

---

# Core Idea

Seqlock uses a **sequence counter**.

```text
Sequence Number
```

Rules:

```text
Even Number
      |
      +--> No Writer Active

Odd Number
      |
      +--> Writer Active
```

Writer operation:

```text
Acquire Lock
      |
      +--> seq++
      |       (odd)
      |
      +--> Modify Data
      |
      +--> seq++
              (even)
```

Readers use the sequence number to determine whether the data they read was consistent. ([EmbeTronicX][1])

---

# How Seqlock Works

## Writer Side

Suppose:

```text
seq = 10
```

Writer enters:

```text
seq = 11
```

Now:

```text
Odd Value
     |
     +--> Writing In Progress
```

After update:

```text
seq = 12
```

Now:

```text
Even Value
     |
     +--> Write Completed
```

([EmbeTronicX][1])

---

## Reader Side

Reader performs:

```text
Step 1:
Read Sequence Number

Step 2:
Read Data

Step 3:
Read Sequence Number Again

Step 4:
Compare
```

If:

```text
Same Even Number
```

Data is valid.

If:

```text
Sequence Changed
       OR
Sequence Odd
```

Reader retries. ([EmbeTronicX][1])

---

# Reader Example

Initial state:

```text
seq = 20
```

Reader:

```text
Read seq = 20

Read data

Read seq = 20
```

Result:

```text
Valid Read
```

---

# Reader During Write

```text
Read seq = 20

Writer Starts

seq = 21

Writer Updates Data

seq = 22

Reader Reads seq = 22
```

Comparison:

```text
20 != 22
```

Result:

```text
Retry Read
```

([EmbeTronicX][1])

---

# Advantages of Seqlock

## Fast Readers

Readers:

```text
No Lock Acquisition
No Spinlock
No Mutex
```

Just:

```text
Read
Verify
Retry If Needed
```

---

## No Writer Starvation

Writer:

```text
Never Waits For Readers
```

Readers retry instead. ([EmbeTronicX][1])

---

## Scales Well

Read-heavy workloads:

```text
Many Readers
Few Writers
```

perform very efficiently. ([Kernel Internals][2])

---

# Limitations

Seqlock is **not a general-purpose lock**.

---

## Cannot Protect Pointers

Bad:

```c
struct node *head;
```

Reason:

```text
Reader May Follow Pointer

Writer Changes Pointer

Reader Crashes
```

Seqlocks are generally unsuitable for pointer-based data structures. ([EmbeTronicX][1])

---

## Reader May Retry Forever

Heavy writes:

```text
Writer
Writer
Writer
Writer
```

Reader:

```text
Read
Retry

Read
Retry

Read
Retry
```

Possible starvation of readers.

---

## Not Suitable For Large Data

Best for:

```text
Counters
Timestamps
Statistics
Simple Structures
```

Not ideal for complex structures. ([EmbeTronicX][1])

---

# When To Use Seqlock

Good:

```text
Timekeeping
Jiffies
Statistics
Configuration Values
Network Counters
Device Status
```

Bad:

```text
Linked Lists
Trees
Pointer Structures
Dynamic Objects
```

([Kernel Internals][2])

---

# Header File

```c
#include <linux/seqlock.h>
```

---

# Seqlock Data Type

```c
seqlock_t etx_seq_lock;
```

---

# Initialization

## Dynamic

```c
seqlock_t etx_seq_lock;

seqlock_init(
        &etx_seq_lock);
```

---

## Static

```c
DEFINE_SEQLOCK(
        etx_seq_lock);
```

([Kernel][3])

---

# Writer APIs

Writers use an embedded spinlock.

---

## write_seqlock()

Acquire writer lock.

```c
write_seqlock(
        &etx_seq_lock);
```

Internally:

```text
Lock Spinlock
Increment Sequence
```

([EmbeTronicX][1])

---

## write_sequnlock()

Release writer lock.

```c
write_sequnlock(
        &etx_seq_lock);
```

Internally:

```text
Increment Sequence
Unlock Spinlock
```

([EmbeTronicX][1])

---

## Example Writer

```c
write_seqlock(
        &etx_seq_lock);

etx_global_variable++;

write_sequnlock(
        &etx_seq_lock);
```

---

# Non-Blocking Writer

## write_tryseqlock()

```c
if(write_tryseqlock(
        &etx_seq_lock))
{
    /* write */
}
```

Returns:

| Value    | Meaning       |
| -------- | ------------- |
| Non-zero | Lock Acquired |
| 0        | Lock Busy     |

([EmbeTronicX][1])

---

# IRQ Variants

---

## write_seqlock_irq()

```c
write_seqlock_irq(
        &etx_seq_lock);
```

Disables interrupts.

---

## write_sequnlock_irq()

```c
write_sequnlock_irq(
        &etx_seq_lock);
```

Enables interrupts.

---

## write_seqlock_irqsave()

```c
unsigned long flags;

write_seqlock_irqsave(
        &etx_seq_lock,
        flags);
```

---

## write_sequnlock_irqrestore()

```c
write_sequnlock_irqrestore(
        &etx_seq_lock,
        flags);
```

Restores original interrupt state. ([EmbeTronicX][1])

---

# Bottom Half Variants

```c
write_seqlock_bh()
write_sequnlock_bh()
```

Used in:

```text
Tasklets
SoftIRQs
```

([EmbeTronicX][1])

---

# Reader APIs

Readers never acquire a lock.

---

## read_seqbegin()

Begin reading.

```c
unsigned int seq;

seq =
read_seqbegin(
        &etx_seq_lock);
```

Returns current sequence number. ([EmbeTronicX][1])

---

## read_seqretry()

Verify read consistency.

```c
read_seqretry(
        &etx_seq_lock,
        seq);
```

Returns:

| Value | Meaning        |
| ----- | -------------- |
| 0     | Data Valid     |
| 1     | Retry Required |

([EmbeTronicX][1])

---

# Reader Example

```c
unsigned int seq;

do
{
    seq =
      read_seqbegin(
            &etx_seq_lock);

    value =
        etx_global_variable;

} while(
     read_seqretry(
            &etx_seq_lock,
            seq));
```

Execution:

```text
Read Seq
Read Data
Verify Seq

Changed?
    |
    +--> Retry

Unchanged?
    |
    +--> Success
```

([EmbeTronicX][1])

---

# Complete Example

## Shared Variable

```c
unsigned long
etx_global_variable = 0;
```

---

## Seqlock

```c
DEFINE_SEQLOCK(
        etx_seq_lock);
```

---

## Writer Thread

```c
while(
  !kthread_should_stop())
{
    write_seqlock(
            &etx_seq_lock);

    etx_global_variable++;

    write_sequnlock(
            &etx_seq_lock);

    msleep(1000);
}
```

---

## Reader Thread

```c
unsigned int seq;
unsigned long value;

do
{
    seq =
      read_seqbegin(
            &etx_seq_lock);

    value =
      etx_global_variable;

} while(
      read_seqretry(
            &etx_seq_lock,
            seq));
```

([EmbeTronicX][1])

---

# Execution Flow

```text
Writer
   |
   +--> seq = 1
   |
   +--> Update Data
   |
   +--> seq = 2

Reader
   |
   +--> Read seq = 2
   |
   +--> Read Data
   |
   +--> Read seq = 2
   |
   +--> Success
```

---

# Seqlock vs Spinlock

| Feature          | Spinlock | Seqlock |
| ---------------- | -------- | ------- |
| Readers Lock     | Yes      | No      |
| Writers Lock     | Yes      | Yes     |
| Reader Retry     | No       | Yes     |
| Writer Priority  | No       | Yes     |
| Pointer Safety   | Yes      | No      |
| Read Performance | Moderate | High    |

([EmbeTronicX][1])

---

# Seqlock vs Read-Write Spinlock

| Feature            | RW Spinlock | Seqlock  |
| ------------------ | ----------- | -------- |
| Multiple Readers   | Yes         | Yes      |
| Reader Locking     | Yes         | No       |
| Writer Starvation  | Possible    | No       |
| Reader Starvation  | Rare        | Possible |
| Pointer Protection | Yes         | No       |
| Read Overhead      | Higher      | Lower    |

([EmbeTronicX][1])

---

# Common Kernel Uses

Linux itself uses sequence counters and seqlocks extensively for:

```text
Timekeeping
Jiffies
Clock Sources
Statistics
Kernel Counters
```

because reads are extremely frequent and writes are relatively rare. ([Kernel Internals][2])

---

# Common Mistakes

## Using Pointers

Wrong:

```c
struct node *head;
```

Protected by seqlock.

Potential:

```text
Reader Uses Invalid Pointer
```

([EmbeTronicX][1])

---

## Long Write Sections

Wrong:

```c
write_seqlock(&lock);

/* lengthy work */

write_sequnlock(&lock);
```

Readers may retry repeatedly.

---

## Sleeping While Holding Write Lock

Wrong:

```c
write_seqlock(&lock);

msleep(100);

write_sequnlock(&lock);
```

Writer lock uses a spinlock internally.

---

# Important APIs Summary

## Initialization

```c
seqlock_init()

DEFINE_SEQLOCK()
```

---

## Writer

```c
write_seqlock()

write_tryseqlock()

write_sequnlock()
```

---

## IRQ Variants

```c
write_seqlock_irq()

write_sequnlock_irq()

write_seqlock_irqsave()

write_sequnlock_irqrestore()
```

---

## Bottom Half Variants

```c
write_seqlock_bh()

write_sequnlock_bh()
```

---

## Reader

```c
read_seqbegin()

read_seqretry()
```

---

# Key Takeaways

* Seqlock is a **writer-priority synchronization mechanism**.
* Readers never acquire a traditional lock.
* Writers use an embedded spinlock for mutual exclusion.
* Readers validate data using a sequence counter.
* If a write occurs during a read, the reader retries.
* Seqlocks eliminate writer starvation.
* Best suited for small, simple, read-mostly data.
* Not suitable for pointer-based or complex dynamic data structures.
* Frequently used in Linux timekeeping and statistics subsystems. ([EmbeTronicX][1])

[1]: https://embetronicx.com/tutorials/linux/device-drivers/seqlock-in-linux-kernel/?utm_source=chatgpt.com "Seqlock in Linux Kernel - Linux Device DriverTutorial Part 31"
[2]: https://kernel-internals.org/locking/seqlock/?utm_source=chatgpt.com "Seqlock - Linux Kernel Internals"
[3]: https://www.kernel.org/doc/html/latest/locking/seqlock.html?utm_source=chatgpt.com "Sequence counters and sequential locks — The Linux Kernel documentation"


## Conclusion
This is just a basic linux device driver which explains about the Seqlock in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/seqlock-in-linux-kernel/
