# Linux Device Driver - Mutex in Linux Kernel

## Overview

A Mutex (**Mutual Exclusion Lock**) is a synchronization mechanism used to protect shared resources from concurrent access by multiple threads.

Only **one thread can own a mutex at a time**.

Mutexes are used to prevent:

* Race conditions
* Data corruption
* Inconsistent shared data access

A mutex has **ownership semantics**:

```text
Thread A locks Mutex
        |
        v
Thread A must unlock Mutex
```

A different thread cannot unlock a mutex it did not acquire.

---

# Why Do We Need Mutex?

Consider two kernel threads accessing the same global variable.

Without synchronization:

```text
Thread1
    |
    +--> global_var++

Thread2
    |
    +--> global_var++
```

Possible execution:

```text
global_var = 0

Thread1 reads 0
Thread2 reads 0

Thread1 writes 1
Thread2 writes 1
```

Expected:

```text
2
```

Actual:

```text
1
```

This is called a **Race Condition**.

---

# Race Condition

A race condition occurs when:

* Multiple threads access shared data
* At least one thread modifies the data
* Access is not synchronized

Result depends on scheduling order.

```text
Thread A
      \
       \
        Shared Data
       /
      /
Thread B
```

Race conditions can cause:

* Wrong values
* Kernel crashes
* Corrupted linked lists
* Memory corruption

---

# What is a Mutex?

Mutex stands for:

```text
Mutual Exclusion
```

Concept:

```text
Shared Resource
       |
       v
     Mutex
       |
       v
Only One Thread Allowed
```

Workflow:

```text
Lock Mutex
     |
     v
Access Shared Resource
     |
     v
Unlock Mutex
```

Any thread that arrives while the mutex is held will sleep until it becomes available.

---

# Mutex vs Spinlock

| Feature                | Mutex           | Spinlock    |
| ---------------------- | --------------- | ----------- |
| Sleep Allowed          | Yes             | No          |
| Context                | Process Context | Any Context |
| Ownership              | Yes             | No          |
| Long Critical Sections | Good            | Bad         |
| ISR Usage              | Not Allowed     | Allowed     |
| Busy Waiting           | No              | Yes         |

Mutexes put the task to sleep when contention occurs, whereas spinlocks keep spinning while waiting.

---

# Mutex Rules

## Rule 1

Mutexes can sleep.

Therefore:

```text
Allowed:
    Process Context
    Kernel Thread

Not Allowed:
    ISR
    Tasklet
    SoftIRQ
```

---

## Rule 2

Mutex has ownership.

```text
Thread A locks
Thread A unlocks
```

Not:

```text
Thread A locks
Thread B unlocks
```

---

## Rule 3

Recursive locking is not allowed.

Wrong:

```c
mutex_lock(&lock);
mutex_lock(&lock);
```

This may deadlock.

---

# Mutex Lifecycle

```text
Create Mutex
      |
      v
mutex_init()
      |
      v
mutex_lock()
      |
      v
Critical Section
      |
      v
mutex_unlock()
```

---

# Header File

```c
#include <linux/mutex.h>
```

Required for all mutex APIs.

---

# Mutex Declaration

## Static Method

Used for global mutexes.

```c
DEFINE_MUTEX(etx_mutex);
```

Equivalent concept:

```text
Create + Initialize
```

in a single statement.

---

# Dynamic Method

Declare:

```c
struct mutex etx_mutex;
```

Initialize:

```c
mutex_init(&etx_mutex);
```

This initializes the mutex in unlocked state.

---

# Locking a Mutex

## mutex_lock()

Acquire mutex.

```c
mutex_lock(&etx_mutex);
```

Behavior:

```text
Mutex Free
      |
      +--> Acquire Immediately

Mutex Busy
      |
      +--> Sleep Until Available
```

The calling task sleeps until the mutex becomes available.

---

# mutex_lock_interruptible()

Interruptible version.

```c
mutex_lock_interruptible(
        &etx_mutex);
```

Return Values:

| Return | Meaning               |
| ------ | --------------------- |
| 0      | Lock Acquired         |
| -EINTR | Interrupted by Signal |

Useful when waiting should be interruptible.

---

# mutex_trylock()

Non-blocking attempt.

```c
if(mutex_trylock(&etx_mutex))
{
    /* lock acquired */
}
```

Returns:

| Return | Meaning |
| ------ | ------- |
| 1      | Success |
| 0      | Busy    |

Does not sleep.

---

# Unlocking a Mutex

## mutex_unlock()

Release mutex.

```c
mutex_unlock(&etx_mutex);
```

After unlocking:

```text
Waiting Thread
        |
        v
Can Acquire Mutex
```

Must be unlocked by the same task that acquired it.

---

# Checking Mutex State

## mutex_is_locked()

```c
mutex_is_locked(
        &etx_mutex);
```

Returns:

| Return | Meaning  |
| ------ | -------- |
| 1      | Locked   |
| 0      | Unlocked |

---

# Kernel Thread Example

## Shared Variable

```c
unsigned long
etx_global_variable = 0;
```

Shared between:

```text
Thread1
Thread2
```

---

# Thread 1

```c
int thread_function1(void *pv)
{
    while(!kthread_should_stop())
    {
        mutex_lock(
                &etx_mutex);

        etx_global_variable++;

        pr_info(
          "Thread1 %lu\n",
          etx_global_variable);

        mutex_unlock(
                &etx_mutex);

        msleep(1000);
    }

    return 0;
}
```

---

# Thread 2

```c
int thread_function2(void *pv)
{
    while(!kthread_should_stop())
    {
        mutex_lock(
                &etx_mutex);

        etx_global_variable++;

        pr_info(
          "Thread2 %lu\n",
          etx_global_variable);

        mutex_unlock(
                &etx_mutex);

        msleep(1000);
    }

    return 0;
}
```

---

# Execution Flow

```text
Thread1
    |
    +--> mutex_lock()

          Mutex Acquired

    |
    +--> Increment Variable

    |
    +--> mutex_unlock()

    |
    +--> Sleep
```

Meanwhile:

```text
Thread2
    |
    +--> Waiting For Mutex
```

After unlock:

```text
Thread2 Acquires Mutex
```

---

# Example Output

```text
Thread1 1
Thread2 2
Thread1 3
Thread2 4
Thread1 5
Thread2 6
```

The value increments correctly because access is serialized by the mutex.

---

# Mutex vs Semaphore

| Feature              | Mutex            | Semaphore                        |
| -------------------- | ---------------- | -------------------------------- |
| Ownership            | Yes              | No                               |
| Unlock By Owner Only | Yes              | No                               |
| Resource Count       | One              | Multiple                         |
| Purpose              | Mutual Exclusion | Resource Counting                |
| Priority Inheritance | Yes              | Typically Yes (Kernel Dependent) |

Mutex is used primarily for protecting critical sections.

---

# Mutex vs Completion

| Mutex                   | Completion     |    |
| ----------------------- | -------------- | -- |
| Protect Shared Resource | Wait For Event |    |
| Lock/Unlock             | Complete/Wait  |    |
| Ownership               | Yes            | No |
| Mutual Exclusion        | Yes            | No |

---

# Common Driver Use Cases

## Linked List Protection

```c
mutex_lock(&list_mutex);

list_add_tail(...);

mutex_unlock(&list_mutex);
```

---

## Device Configuration

```c
mutex_lock(&device_mutex);

device_config();

mutex_unlock(&device_mutex);
```

---

## Shared Buffer Access

```c
mutex_lock(&buffer_mutex);

copy_data();

mutex_unlock(&buffer_mutex);
```

---

## File Operations

```c
open()
read()
write()
ioctl()
```

Prevent simultaneous modification of shared driver data.

---

# Common Mistakes

## Forgetting Unlock

Wrong:

```c
mutex_lock(&lock);

/* work */

return;
```

Correct:

```c
mutex_lock(&lock);

/* work */

mutex_unlock(&lock);

return;
```

---

## Using Mutex in ISR

Wrong:

```c
irq_handler()
{
    mutex_lock(&lock);
}
```

Reason:

```text
Mutex Can Sleep
ISR Cannot Sleep
```

---

## Double Locking

Wrong:

```c
mutex_lock(&lock);

mutex_lock(&lock);
```

May cause deadlock.

---

# Important APIs Summary

## Initialization

```c
DEFINE_MUTEX()

mutex_init()
```

---

## Lock

```c
mutex_lock()

mutex_lock_interruptible()

mutex_trylock()
```

---

## Unlock

```c
mutex_unlock()
```

---

## Status

```c
mutex_is_locked()
```

---

# Key Takeaways

* Mutex provides mutual exclusion for shared resources.
* Only one thread can hold a mutex at a time.
* Mutexes prevent race conditions.
* Mutexes can sleep and therefore cannot be used in ISR, Tasklets, or SoftIRQs.
* `mutex_lock()` blocks until the lock becomes available.
* `mutex_trylock()` does not block.
* The thread that locks a mutex must unlock it.
* Mutexes are ideal for protecting linked lists, buffers, device state, and shared driver data.
* Kernel threads and file operations commonly use mutexes for synchronization.


## Conclusion
This is just a basic linux device driver which explains about the mutex in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/linux-device-driver-tutorial-mutex-in-linux-kernel/
