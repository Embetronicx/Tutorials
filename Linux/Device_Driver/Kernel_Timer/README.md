# Linux Device Driver - Kernel Timer in Linux

## Overview

A Kernel Timer allows a Linux device driver to execute a function after a specified time interval.

Unlike hardware timers, Linux kernel timers are software timers managed by the kernel timer subsystem using **jiffies** and timer interrupts. They are useful for scheduling future work without blocking a thread.

Common use cases:

* Device polling
* Timeout detection
* Periodic status checks
* Retry mechanisms
* Delayed operations
* Heartbeat monitoring

---

# What is a Timer?

A timer measures a time interval.

```text
Current Time
     |
     +-------> Timer Expires
                     |
                     +--> Callback Function Executes
```

In Linux, timers are driven by periodic kernel timer interrupts. The kernel maintains an internal counter that increments every clock tick since boot. This counter is represented through **jiffies**.

---

# Kernel Timer Architecture

```text
Driver Loads
      |
      v
Create Timer
      |
      v
Start Timer
      |
      v
Timer Expires
      |
      v
Callback Function
      |
      +--> Stop Timer
      |
      +--> Restart Timer
```

If the callback restarts the timer, it behaves like a periodic timer.

---

# Uses of Kernel Timers

## Device Polling

```text
Timer
   |
   +--> Check Device Status
```

Used when hardware does not generate interrupts.

---

## Communication Timeout

```text
Send Request
      |
      +--> Start Timer
      |
      +--> No Response
      |
      +--> Timeout Error
```

Used in networking and protocol stacks.

---

## Periodic Monitoring

```text
Every 5 Seconds
      |
      +--> Read Sensor
```

Useful for watchdogs and health monitoring.

---

# Header Files

```c
#include <linux/timer.h>
#include <linux/jiffies.h>
```

Required for timer APIs and jiffies support.

---

# Kernel Timer Structure

```c
struct timer_list
{
    unsigned long expires;

    void (*function)(unsigned long);

    unsigned long data;
};
```

Important Fields:

| Field    | Purpose                    |
| -------- | -------------------------- |
| expires  | Expiration time in jiffies |
| function | Callback function          |
| data     | Data passed to callback    |

Modern kernels use `timer_setup()` and callback receives:

```c
struct timer_list *timer
```

instead of `unsigned long data`.

---

# Jiffies

## What are Jiffies?

Jiffies represent kernel clock ticks.

```c
jiffies
```

Example:

```text
System Boot
      |
      +--> jiffies = 0

1 Tick Later
      |
      +--> jiffies = 1
```

Every timer expiration is specified relative to jiffies.

---

# Time Conversion

## Milliseconds to Jiffies

```c
msecs_to_jiffies(5000)
```

Convert:

```text
5000 ms
    |
    +--> Jiffies
```

Example:

```c
jiffies +
msecs_to_jiffies(5000)
```

Means:

```text
Current Time + 5 Seconds
```

---

# Timer Initialization Methods

Linux provides multiple initialization APIs.

---

# Method 1 - init_timer()

```c
init_timer(
        &etx_timer);
```

Older API.

After initialization:

```c
etx_timer.function = timer_callback;
etx_timer.data = 0;
```

Not recommended for modern kernels.

---

# Method 2 - setup_timer()

Older kernels:

```c
setup_timer(
        &etx_timer,
        timer_callback,
        0);
```

Callback:

```c
void timer_callback(
        unsigned long data)
{
}
```

Used in legacy kernels.

---

# Method 3 - timer_setup()

Recommended API.

```c
timer_setup(
        &etx_timer,
        timer_callback,
        0);
```

Callback:

```c
void timer_callback(
        struct timer_list *t)
{
}
```

Most modern kernels use this API.

---

# Method 4 - DEFINE_TIMER()

Static initialization.

```c
DEFINE_TIMER(
        etx_timer,
        timer_callback,
        0,
        0);
```

Kernel creates and initializes timer automatically.

---

# Starting a Timer

## add_timer()

```c
add_timer(
        &etx_timer);
```

Starts timer.

Before calling:

```c
etx_timer.expires =
        jiffies +
        msecs_to_jiffies(5000);
```

---

# Recommended Start Method

Modern drivers usually use:

```c
mod_timer(
        &etx_timer,
        jiffies +
        msecs_to_jiffies(5000));
```

because it works for both:

```text
New Timer
Existing Timer
```

---

# Modifying Timer Timeout

## mod_timer()

```c
mod_timer(
        &etx_timer,
        expires);
```

Example:

```c
mod_timer(
        &etx_timer,
        jiffies +
        msecs_to_jiffies(5000));
```

Equivalent conceptually to:

```c
del_timer();

update expires;

add_timer();
```

but much more efficient.

---

# Return Value

```c
ret = mod_timer(...)
```

| Value | Meaning            |
| ----- | ------------------ |
| 0     | Timer was inactive |
| 1     | Timer was active   |

This is status information, not an error code.

---

# Creating a Periodic Timer

Kernel timers are:

```text
One-Shot Timers
```

by default.

To make them periodic:

```c
void timer_callback(
        struct timer_list *t)
{
    pr_info("Timer Fired\n");

    mod_timer(
        &etx_timer,
        jiffies +
        msecs_to_jiffies(5000));
}
```

Execution:

```text
5 Seconds
     |
     +--> Callback

     |
     +--> Restart Timer

     |
     +--> Callback Again
```

---

# Example Driver

## Timer Declaration

```c
static struct timer_list etx_timer;
```

---

## Timer Initialization

```c
timer_setup(
        &etx_timer,
        timer_callback,
        0);
```

---

## Start Timer

```c
mod_timer(
        &etx_timer,
        jiffies +
        msecs_to_jiffies(5000));
```

---

## Callback

```c
void timer_callback(
        struct timer_list *data)
{
    pr_info(
      "Timer Callback\n");

    mod_timer(
        &etx_timer,
        jiffies +
        msecs_to_jiffies(5000));
}
```

This creates a timer that fires every 5 seconds.

---

# Stopping a Timer

## del_timer()

```c
del_timer(
        &etx_timer);
```

Deactivates timer.

Return:

| Value | Meaning                |
| ----- | ---------------------- |
| 0     | Timer already inactive |
| 1     | Active timer removed   |

---

# del_timer_sync()

```c
del_timer_sync(
        &etx_timer);
```

Removes timer and waits for callback completion.

Useful during:

```text
Module Removal
Driver Cleanup
```

Safer than `del_timer()` when timer callback may still be running.

---

# Check Timer Status

## timer_pending()

```c
timer_pending(
        &etx_timer);
```

Returns:

| Value | Meaning     |
| ----- | ----------- |
| 0     | Not Pending |
| 1     | Pending     |

Used to check whether timer is currently active.

---

# Execution Flow

```text
insmod driver.ko
        |
        v
timer_setup()
        |
        v
mod_timer()
        |
        v
5 Seconds
        |
        v
timer_callback()
        |
        v
mod_timer()
        |
        v
Repeat
```

---

# Sample Output

```text
Device Driver Insert...Done!!!

Timer Callback function Called [0]

Timer Callback function Called [1]

Timer Callback function Called [2]

Timer Callback function Called [3]
```

Each callback occurs approximately every 5 seconds.

---

# Important Limitation

Timer callback executes in:

```text
Interrupt Context
```

NOT process context.

---

# Not Allowed Inside Timer Callback

## Sleeping

Wrong:

```c
msleep(100);
```

---

## Mutex

Wrong:

```c
mutex_lock(&lock);
```

---

## Access User Space

Wrong:

```c
copy_to_user(...);
```

---

## Long Processing

Wrong:

```c
Huge Computation
Large File Operations
```

Timer callbacks should be short and fast.

---

# Timer vs Kernel Thread

| Feature            | Kernel Timer | Kernel Thread |
| ------------------ | ------------ | ------------- |
| Context            | Interrupt    | Process       |
| Sleep Allowed      | No           | Yes           |
| Periodic Execution | Yes          | Yes           |
| Long Processing    | No           | Yes           |
| CPU Usage          | Low          | Higher        |

---

# Timer vs Workqueue

| Feature           | Timer     | Workqueue |
| ----------------- | --------- | --------- |
| Context           | Interrupt | Process   |
| Sleep Allowed     | No        | Yes       |
| Delayed Execution | Yes       | Yes       |
| Long Processing   | No        | Yes       |

Common pattern:

```text
Timer Expires
      |
      +--> Queue Workqueue
      |
      +--> Workqueue Does Heavy Work
```

---

# Common Driver Use Cases

## Watchdog

```text
Every 1 Second
      |
      +--> Feed Watchdog
```

---

## Network Timeout

```text
Send Packet
      |
      +--> Start Timer
      |
      +--> No ACK
      |
      +--> Timeout
```

---

## Device Polling

```text
Every 100 ms
      |
      +--> Read Status Register
```

---

## Heartbeat

```text
Periodic Timer
      |
      +--> Health Check
```

---

# Important APIs Summary

## Initialization

```c
init_timer()

setup_timer()

timer_setup()

DEFINE_TIMER()
```

---

## Start

```c
add_timer()

mod_timer()
```

---

## Stop

```c
del_timer()

del_timer_sync()
```

---

## Status

```c
timer_pending()
```

---

## Time Conversion

```c
jiffies

msecs_to_jiffies()
```

---

# Key Takeaways

* Kernel timers schedule execution of a callback in the future.
* Modern kernels should use `timer_setup()`.
* Timer expiration is based on **jiffies**.
* `mod_timer()` is the preferred API for starting and updating timers.
* Kernel timers are one-shot by default.
* Re-arming the timer inside the callback creates periodic behavior.
* Timer callbacks execute in interrupt context.
* Timer callbacks cannot sleep, acquire mutexes, or perform long operations.
* `del_timer_sync()` is preferred during driver cleanup.
* Timers are ideal for polling, watchdogs, retries, and timeout handling.


## Conclusion
This is just a basic linux device driver which explains about the kernel timer in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/using-kernel-timer-in-linux-device-driver/
