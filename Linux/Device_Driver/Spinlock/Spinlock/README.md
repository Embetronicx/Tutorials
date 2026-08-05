# Linux Device Driver - Spinlock in Linux Kernel (Part 1)

## Overview

A Spinlock is a lightweight synchronization mechanism used to protect shared resources from concurrent access.

Like a mutex, it provides mutual exclusion, but unlike a mutex, a thread does **not sleep** when the lock is unavailable.

Instead, it continuously checks the lock in a loop (**spins**) until the lock becomes available.

---

# Why Spinlocks?

Consider two kernel threads updating a shared variable.

Without synchronization:

```text
Thread1                    Thread2
   |                           |
Read Value = 0           Read Value = 0
   |                           |
Increment                 Increment
   |                           |
Write 1                   Write 1
```

Expected:

```text
Global Variable = 2
```

Actual:

```text
Global Variable = 1
```

This is a race condition. Spinlocks prevent this problem.

---

# What is a Spinlock?

A Spinlock is a:

```text
Single Holder Lock
```

States:

```text
UNLOCKED
LOCKED
```

When a thread attempts to acquire a locked spinlock:

```text
Mutex:
    Sleep

Spinlock:
    Keep Trying (Spin)
```

This makes spinlocks extremely fast for very short critical sections.

---

# Mutex vs Spinlock

| Feature          | Mutex | Spinlock   |
| ---------------- | ----- | ---------- |
| Waiting Method   | Sleep | Busy Wait  |
| Context Switch   | Yes   | No         |
| Can Sleep        | Yes   | No         |
| ISR Safe         | No    | Yes        |
| Critical Section | Long  | Very Short |
| Ownership        | Yes   | No         |

Spinlocks are preferred when:

* Critical section is extremely short
* Sleeping is not allowed
* Interrupt context is involved

---

# How Spinlock Works

```text
CPU0
 |
 +--> spin_lock()
 |
 +--> Critical Section
 |
 +--> spin_unlock()

CPU1
 |
 +--> spin_lock()
 |
 +--> Spins Until CPU0 Releases Lock
```

Only one CPU enters the protected section at a time.

---

# When to Use Spinlock?

Suitable for:

* Shared kernel variables
* Shared linked lists
* Interrupt handlers
* Tasklets
* SoftIRQs
* Device driver state protection

Example:

```text
ISR
 |
 +--> Shared Buffer

Kernel Thread
 |
 +--> Same Shared Buffer
```

A spinlock protects access to the shared buffer.

---

# Important Rule

Never hold a spinlock for a long time.

Bad:

```c
spin_lock(&lock);

msleep(1000);

spin_unlock(&lock);
```

Good:

```c
spin_lock(&lock);

shared_var++;

spin_unlock(&lock);
```

Because while one CPU holds the lock, other CPUs waste CPU cycles spinning.

---

# Kernel Configuration Behavior

### SMP Disabled

If:

```text
CONFIG_SMP = n
CONFIG_PREEMPT = n
```

Spinlocks are effectively unnecessary because only one execution path can run at a time.

---

### SMP Disabled + PREEMPT Enabled

If:

```text
CONFIG_SMP = n
CONFIG_PREEMPT = y
```

Spinlocks disable preemption to prevent races.

---

# Header File

```c
#include <linux/spinlock.h>
```

Required for all spinlock APIs.

---

# Spinlock Declaration

## Static Initialization

```c
DEFINE_SPINLOCK(etx_spinlock);
```

Expands conceptually to:

```c
spinlock_t etx_spinlock =
        __SPIN_LOCK_UNLOCKED(
                etx_spinlock);
```

Creates a spinlock in unlocked state.

---

# Dynamic Initialization

Declare:

```c
spinlock_t etx_spinlock;
```

Initialize:

```c
spin_lock_init(
        &etx_spinlock);
```

Used when initialization is required at runtime.

---

# Approach 1: User Context Locking

Used between:

```text
Kernel Thread
        ↔
Kernel Thread
```

---

## spin_lock()

Acquire lock.

```c
spin_lock(
        &etx_spinlock);
```

Behavior:

```text
Unlocked
    |
    +--> Acquire

Locked
    |
    +--> Spin Forever Until Free
```

---

## spin_trylock()

Non-blocking lock attempt.

```c
if(spin_trylock(
        &etx_spinlock))
{
    /* acquired */
}
```

Returns:

| Return   | Meaning |
| -------- | ------- |
| Non-zero | Success |
| 0        | Failed  |

Does not spin.

---

## spin_unlock()

Release lock.

```c
spin_unlock(
        &etx_spinlock);
```

Allows another waiting CPU to acquire it.

---

## spin_is_locked()

Check lock state.

```c
spin_is_locked(
        &etx_spinlock);
```

Returns:

| Return   | Meaning  |
| -------- | -------- |
| Non-zero | Locked   |
| 0        | Unlocked |

---

# Approach 2: Bottom Half Locking

Used between:

```text
Tasklet
      ↔
Tasklet

SoftIRQ
      ↔
SoftIRQ
```

Standard spinlock APIs are typically sufficient.

---

# Approach 3: User Context + Bottom Half

Used when data is shared between:

```text
Kernel Thread
      ↔
Tasklet

Kernel Thread
      ↔
SoftIRQ
```

---

## spin_lock_bh()

```c
spin_lock_bh(
        &etx_spinlock);
```

What it does:

```text
Disable SoftIRQ
        +
Acquire Spinlock
```

The `_bh` suffix means:

```text
Bottom Half
```

Prevents tasklets and softirqs from executing on the current CPU.

---

## spin_unlock_bh()

```c
spin_unlock_bh(
        &etx_spinlock);
```

What it does:

```text
Release Spinlock
        +
Enable SoftIRQ
```

---

# Kernel Thread Example

## Global Variable

```c
unsigned long
etx_global_variable = 0;
```

Protected using:

```c
DEFINE_SPINLOCK(
        etx_spinlock);
```

---

## Thread 1

```c
int thread_function1(
        void *pv)
{
    while(
      !kthread_should_stop())
    {
        spin_lock(
            &etx_spinlock);

        etx_global_variable++;

        printk(
          "Thread1 %lu\n",
          etx_global_variable);

        spin_unlock(
            &etx_spinlock);
    }

    return 0;
}
```

---

## Thread 2

```c
int thread_function2(
        void *pv)
{
    while(
      !kthread_should_stop())
    {
        spin_lock(
            &etx_spinlock);

        etx_global_variable++;

        printk(
          "Thread2 %lu\n",
          etx_global_variable);

        spin_unlock(
            &etx_spinlock);
    }

    return 0;
}
```

Both threads safely update the shared variable.

---

# Execution Flow

```text
Thread1
    |
    +--> spin_lock()
    |
    +--> Critical Section
    |
    +--> spin_unlock()

Thread2
    |
    +--> Waiting (Spinning)
```

After unlock:

```text
Thread2 Acquires Lock
```

---

# Sample Output

```text
Thread1 1
Thread2 2
Thread1 3
Thread2 4
Thread1 5
Thread2 6
```

The shared variable remains consistent because only one thread enters the critical section at a time.

---

# Spinlock vs Read-Write Spinlock

| Feature              | Spinlock       | Read-Write Spinlock |
| -------------------- | -------------- | ------------------- |
| Readers              | One at a Time  | Multiple Readers    |
| Writers              | One            | One                 |
| Complexity           | Simple         | Higher              |
| Read-Heavy Workloads | Less Efficient | Better              |

Read-write spinlocks allow multiple simultaneous readers but only one writer.

---

# Common Driver Use Cases

## Shared Buffer

```c
spin_lock(&buffer_lock);

/* access buffer */

spin_unlock(&buffer_lock);
```

---

## Interrupt Handler

```c
irq_handler()
{
    spin_lock(&irq_lock);

    /* update shared data */

    spin_unlock(&irq_lock);
}
```

---

## Linked List Protection

```c
spin_lock(&list_lock);

list_add_tail(...);

spin_unlock(&list_lock);
```

---

## Statistics Counters

```c
spin_lock(&stats_lock);

packet_count++;

spin_unlock(&stats_lock);
```

---

# Common Mistakes

## Sleeping While Holding Spinlock

Wrong:

```c
spin_lock(&lock);

msleep(100);

spin_unlock(&lock);
```

Spinlocks must not sleep.

---

## Large Critical Sections

Wrong:

```c
spin_lock(&lock);

/* lengthy processing */

spin_unlock(&lock);
```

Keep critical sections extremely short.

---

## Missing Unlock

Wrong:

```c
spin_lock(&lock);

return;
```

Causes permanent lockup.

Correct:

```c
spin_lock(&lock);

/* work */

spin_unlock(&lock);
```

---

# Important APIs Summary

## Initialization

```c
DEFINE_SPINLOCK()

spin_lock_init()
```

---

## Lock

```c
spin_lock()

spin_trylock()
```

---

## Unlock

```c
spin_unlock()
```

---

## Status

```c
spin_is_locked()
```

---

## Bottom Half Protection

```c
spin_lock_bh()

spin_unlock_bh()
```

---

# Key Takeaways

* Spinlock is a lightweight mutual exclusion mechanism.
* Waiting threads do not sleep; they continuously spin.
* Spinlocks are ideal for very short critical sections.
* Spinlocks can be used in interrupt context.
* Spinlocks must never sleep or block.
* `spin_lock()` acquires the lock and waits by spinning.
* `spin_trylock()` attempts acquisition without waiting.
* `spin_lock_bh()` protects shared data between user context and bottom halves.
* Use mutexes for long operations and spinlocks for short, low-latency critical sections.
* Excessive spinlock holding time can significantly hurt SMP system performance.


## Conclusion
This is just a basic linux device driver. This will explains spinlock in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/spinlock-in-linux-kernel-1/
