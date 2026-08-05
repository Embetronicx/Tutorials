# Linux Device Driver - Completion in Linux Kernel

## Overview

A **Completion** is a synchronization mechanism used when one thread must wait until another thread finishes a specific task.

Think of it as:

```text
Thread A
   |
   +--> Wait Until Event Happens
                    |
                    v
                Thread B
                    |
                    +--> Finish Work
                    |
                    +--> Notify Thread A
```

Completion provides a simple, race-free mechanism for one execution context to wait for an event and another execution context to signal that the event has occurred. It is built on top of Linux waitqueues. ([EmbeTronicX][1])

---

# Why Do We Need Completion?

Without completion:

```text
Thread A
   |
   +--> while(flag == 0)
             ;
```

Problems:

* CPU waste (busy waiting)
* Race conditions
* Poor readability
* Difficult synchronization

With completion:

```text
Thread A
    |
    +--> Sleep

Thread B
    |
    +--> Work Finished
    |
    +--> Wake Thread A
```

Completion provides efficient sleep/wakeup behavior using the scheduler. ([Kernel][2])

---

# Real World Example

Imagine ordering food:

```text
Customer
    |
    +--> Wait

Chef
    |
    +--> Cook Food
    |
    +--> Ring Bell

Customer
    |
    +--> Resume
```

Customer = Waiting Thread

Chef = Worker Thread

Bell = Completion Event

---

# Completion vs Wait Queue

| Feature                      | Wait Queue | Completion |
| ---------------------------- | ---------- | ---------- |
| General Purpose              | Yes        | No         |
| Event Synchronization        | Possible   | Excellent  |
| Complexity                   | Higher     | Lower      |
| Readability                  | Moderate   | High       |
| Race-Free Event Notification | Manual     | Built-In   |

Completion is essentially a specialized waitqueue designed for event synchronization. ([EmbeTronicX][1])

---

# Completion Architecture

```text
Thread A
   |
   +--> wait_for_completion()
            |
            +--> Sleep

Thread B
   |
   +--> complete()
            |
            +--> Wake Thread A
```

---

# Internal Structure

Include:

```c
#include <linux/completion.h>
```

Kernel structure:

```c
struct completion
{
    unsigned int done;
    wait_queue_head_t wait;
};
```

Fields:

| Field | Description     |
| ----- | --------------- |
| done  | Completion flag |
| wait  | Wait queue      |

The `done` field indicates whether the event has been completed. ([EmbeTronicX][1])

---

# Completion Lifecycle

```text
Create Completion
        |
        v
Initialize
        |
        v
wait_for_completion()
        |
        v
Sleep
        |
        v
complete()
        |
        v
Wake Up
```

---

# Static Initialization

## DECLARE_COMPLETION()

```c
DECLARE_COMPLETION(
        data_read_done);
```

Creates and initializes completion.

Example:

```c
static DECLARE_COMPLETION(
        data_ready);
```

No need for `init_completion()`. ([EmbeTronicX][1])

---

# Dynamic Initialization

Declare:

```c
struct completion
        data_ready;
```

Initialize:

```c
init_completion(
        &data_ready);
```

This:

```text
Initializes Wait Queue
Sets done = 0
```

Meaning:

```text
Not Completed Yet
```

([EmbeTronicX][1])

---

# Reinitialize Completion

## reinit_completion()

```c
reinit_completion(
        &data_ready);
```

Used when:

```text
Reuse Existing Completion
```

Resets:

```text
done = 0
```

without reinitializing the waitqueue. ([EmbeTronicX][1])

---

# Waiting For Completion

The waiting thread sleeps until another thread signals completion.

---

## wait_for_completion()

```c
wait_for_completion(
        &data_ready);
```

Behavior:

```text
Not Completed
       |
       +--> Sleep

Completed
       |
       +--> Continue
```

Characteristics:

* Sleeps indefinitely
* Not interruptible
* No timeout

([EmbeTronicX][1])

---

## wait_for_completion_timeout()

```c
wait_for_completion_timeout(
        &data_ready,
        timeout);
```

Example:

```c
wait_for_completion_timeout(
        &data_ready,
        msecs_to_jiffies(5000));
```

Wait:

```text
Maximum 5 Seconds
```

Return:

| Value | Meaning   |
| ----- | --------- |
| 0     | Timed Out |
| >0    | Completed |

([EmbeTronicX][1])

---

## wait_for_completion_interruptible()

```c
wait_for_completion_interruptible(
        &data_ready);
```

Can be interrupted by signals.

Returns:

| Value        | Meaning     |
| ------------ | ----------- |
| 0            | Completed   |
| -ERESTARTSYS | Interrupted |

([EmbeTronicX][1])

---

## wait_for_completion_interruptible_timeout()

```c
wait_for_completion_interruptible_timeout(
        &data_ready,
        timeout);
```

Features:

* Interruptible
* Timeout supported

([EmbeTronicX][1])

---

## wait_for_completion_killable()

```c
wait_for_completion_killable(
        &data_ready);
```

Interruptible only by fatal signals.

([EmbeTronicX][1])

---

## wait_for_completion_killable_timeout()

```c
wait_for_completion_killable_timeout(
        &data_ready,
        timeout);
```

Supports:

* Kill signal
* Timeout

([EmbeTronicX][1])

---

# Non-Blocking Wait

## try_wait_for_completion()

```c
if(try_wait_for_completion(
        &data_ready))
{
    /* completed */
}
```

Behavior:

```text
Completed
     |
     +--> Return TRUE

Not Completed
     |
     +--> Return FALSE
```

No sleeping.

Safe in IRQ context. ([EmbeTronicX][1])

---

# Signaling Completion

The worker thread notifies waiting threads.

---

## complete()

Wake one waiting task.

```c
complete(
        &data_ready);
```

Behavior:

```text
Thread Sleeping
        |
        +--> Wake One
```

FIFO wake-up order is maintained. ([Kernel][2])

---

## complete_all()

Wake all waiting tasks.

```c
complete_all(
        &data_ready);
```

Behavior:

```text
Thread1 Sleeping
Thread2 Sleeping
Thread3 Sleeping

       |
       +--> Wake All
```

Useful when multiple threads wait for the same event. ([EmbeTronicX][1])

---

# Checking Completion Status

## completion_done()

```c
completion_done(
        &data_ready);
```

Returns:

| Value | Meaning       |
| ----- | ------------- |
| 0     | Not Completed |
| 1     | Completed     |

Safe in interrupt context. ([EmbeTronicX][1])

---

# Simple Example

## Waiting Thread

```c
static int wait_thread_fn(
        void *data)
{
    pr_info(
      "Waiting...\n");

    wait_for_completion(
            &data_ready);

    pr_info(
      "Completed\n");

    return 0;
}
```

---

## Worker Thread

```c
static int worker_thread_fn(
        void *data)
{
    msleep(5000);

    complete(
        &data_ready);

    return 0;
}
```

---

# Execution Flow

```text
Thread A
   |
   +--> wait_for_completion()
   |
   +--> Sleep

Thread B
   |
   +--> Do Work
   |
   +--> complete()

Thread A
   |
   +--> Wake Up
```

---

# Typical Driver Example

## Firmware Loading

```text
Driver
   |
   +--> Request Firmware
   |
   +--> Wait

Firmware Thread
   |
   +--> Load Firmware
   |
   +--> complete()
```

---

## DMA Transfer

```text
Start DMA
     |
     +--> Wait

DMA ISR
     |
     +--> complete()
```

---

## Device Initialization

```text
Main Driver
      |
      +--> Wait

Worker Thread
      |
      +--> Hardware Setup
      |
      +--> complete()
```

---

# Completion vs Semaphore

| Feature            | Completion | Semaphore |
| ------------------ | ---------- | --------- |
| Event Notification | Yes        | Limited   |
| Resource Counting  | No         | Yes       |
| One-Time Event     | Excellent  | Poor      |
| Simplicity         | High       | Moderate  |

---

# Completion vs Mutex

| Feature               | Completion | Mutex |
| --------------------- | ---------- | ----- |
| Synchronization Event | Yes        | No    |
| Resource Protection   | No         | Yes   |
| Lock Ownership        | No         | Yes   |
| Sleep/Wakeup          | Yes        | Yes   |

---

# Completion vs Wait Queue

| Feature                 | Completion | Wait Queue |
| ----------------------- | ---------- | ---------- |
| Specialized Event Sync  | Yes        | No         |
| Simplicity              | High       | Lower      |
| Explicit Wake Condition | No         | Yes        |
| Readability             | Excellent  | Moderate   |

---

# Common Driver Use Cases

## DMA Completion

```text
Start DMA
      |
      +--> Wait

DMA Interrupt
      |
      +--> complete()
```

---

## Firmware Loading

```text
Load Firmware
       |
       +--> Wait

Firmware Ready
       |
       +--> complete()
```

---

## Hardware Initialization

```text
Init Driver
      |
      +--> Wait

Hardware Ready
      |
      +--> complete()
```

---

## Thread Synchronization

```text
Thread A Waits

Thread B Finishes

Thread B Calls complete()
```

---

# Common Mistakes

## Forgetting Initialization

Wrong:

```c
struct completion comp;

wait_for_completion(
        &comp);
```

Correct:

```c
init_completion(
        &comp);
```

---

## Double init_completion()

Wrong:

```c
init_completion(&comp);

init_completion(&comp);
```

Use:

```c
reinit_completion(
        &comp);
```

instead. ([Linux Kernel Documentation][3])

---

## Waiting in Atomic Context

Wrong:

```c
spin_lock(&lock);

wait_for_completion(
        &comp);
```

Reason:

```text
wait_for_completion()
Can Sleep
```

Only use in process context. ([Linux Kernel Documentation][3])

---

# Important APIs Summary

## Initialization

```c
DECLARE_COMPLETION()

init_completion()

reinit_completion()
```

---

## Waiting

```c
wait_for_completion()

wait_for_completion_timeout()

wait_for_completion_interruptible()

wait_for_completion_interruptible_timeout()

wait_for_completion_killable()

wait_for_completion_killable_timeout()

try_wait_for_completion()
```

---

## Wake Up

```c
complete()

complete_all()
```

---

## Status

```c
completion_done()
```

---

# Key Takeaways

* Completion is a synchronization mechanism for **event notification**.
* It is built on top of Linux waitqueues.
* One thread waits using `wait_for_completion()`.
* Another thread signals using `complete()`.
* `complete()` wakes one waiter; `complete_all()` wakes all waiters.
* Completion eliminates busy waiting and race-prone polling loops.
* It is ideal for DMA completion, firmware loading, hardware initialization, and thread synchronization.
* Waiting APIs can sleep and must be used only in process context.
* Completion code is generally simpler and clearer than using semaphores or raw waitqueues for event synchronization. ([EmbeTronicX][1])

[1]: https://embetronicx.com/tutorials/linux/device-drivers/completion-in-linux/?utm_source=chatgpt.com "Completion in Linux - Linux Device Driver Tutorial Part 28"
[2]: https://www.kernel.org/doc/html/latest/scheduler/completion.html?utm_source=chatgpt.com "Completions - “wait for completion” barrier APIs — The Linux Kernel documentation"
[3]: https://docs.kernel.org/scheduler/completion.html?utm_source=chatgpt.com "Completions - “wait for completion” barrier APIs — The Linux Kernel documentation"


## Conclusion
This is just a basic linux device driver. This will explain completion in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/completion-in-linux/
