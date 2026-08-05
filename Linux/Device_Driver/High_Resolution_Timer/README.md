# Linux Device Driver - High Resolution Timer (hrtimer)

## Overview

A High Resolution Timer (**HRT**, `hrtimer`) provides precise timer functionality in the Linux kernel with **nanosecond resolution**.

Unlike traditional kernel timers that are based on **jiffies**, High Resolution Timers use **64-bit nanosecond time values** and are suitable for applications requiring accurate timing. ([EmbeTronicX][1])

---

# Why High Resolution Timer?

## Kernel Timer Limitation

Traditional kernel timers:

```text
Kernel Timer
      |
      +--> Based on Jiffies
      |
      +--> Tick Resolution
```

Example:

```text
HZ = 100

1 Tick = 10 ms
```

Cannot accurately schedule:

```text
1 us
50 us
100 ns
```

operations.

---

## High Resolution Timer

```text
High Resolution Timer
        |
        +--> Nanosecond Resolution
        |
        +--> High Accuracy
```

Suitable for:

* Multimedia
* Real-time systems
* Precision device drivers
* Industrial control
* Sensor sampling

Kernel timers are jiffies-based, whereas hrtimers are based on high-resolution time values. ([EmbeTronicX][1])

---

# Kernel Requirements

High-resolution timer support must be enabled:

```text
CONFIG_HIGH_RES_TIMERS=y
```

Check:

```bash
grep CONFIG_HIGH_RES_TIMERS \
/boot/config-$(uname -r)
```

Expected:

```text
CONFIG_HIGH_RES_TIMERS=y
```

High-resolution timers are available in Linux kernels beginning with version 2.6.21 when enabled in kernel configuration. ([EmbeTronicX][1])

---

# Kernel Timer vs High Resolution Timer

| Feature          | Kernel Timer | High Resolution Timer |
| ---------------- | ------------ | --------------------- |
| Resolution       | Jiffies      | Nanoseconds           |
| Precision        | Lower        | Very High             |
| Timing Base      | Tick Driven  | High Resolution Clock |
| Data Structure   | Timer Wheel  | Red-Black Tree        |
| Real-Time Usage  | Limited      | Excellent             |
| Multimedia Usage | Moderate     | Excellent             |

Linux uses a red-black tree for hrtimers to maintain timers in time order efficiently. ([EmbeTronicX][1])

---

# Typical Use Cases

## Multimedia

```text
Audio Playback
      |
      +--> Precise Timing
```

---

## Sensor Sampling

```text
Every 100 us
      |
      +--> Read Sensor
```

---

## Industrial Control

```text
Motor Control
      |
      +--> Accurate Trigger
```

---

## Driver Timeout

```text
Command Sent
      |
      +--> Start hrtimer
      |
      +--> Timeout Event
```

Primary users include multimedia subsystems and applications needing precise timed events. ([EmbeTronicX][1])

---

# Required Header Files

```c
#include <linux/hrtimer.h>
#include <linux/ktime.h>
```

---

# hrtimer Structure

```c
struct hrtimer
{
    struct rb_node node;

    ktime_t expires;

    int (*function)(
        struct hrtimer *);

    struct hrtimer_base *base;
};
```

Important fields:

| Field    | Purpose             |
| -------- | ------------------- |
| node     | Red-black tree node |
| expires  | Expiration time     |
| function | Callback            |
| base     | Timer base          |

([EmbeTronicX][1])

---

# ktime_t

High Resolution Timers use:

```c
ktime_t
```

which stores time values with nanosecond precision.

Example:

```c
ktime_t time;
```

---

# ktime_set()

Creates a ktime value.

```c
ktime_t ktime_set(
        long secs,
        long nsecs);
```

Example:

```c
ktime_t ktime;

ktime =
    ktime_set(
        5,
        0);
```

Represents:

```text
5 Seconds
```

Example:

```c
ktime_set(
        4,
        1000000000);
```

Represents:

```text
4 Seconds
+
1 Second

=
5 Seconds
```

([EmbeTronicX][1])

---

# Timer Callback Function

Callback executes when timer expires.

```c
enum hrtimer_restart
timer_callback(
        struct hrtimer *timer)
{
    return HRTIMER_NORESTART;
}
```

Return values:

| Return Value      | Meaning        |
| ----------------- | -------------- |
| HRTIMER_NORESTART | One-shot timer |
| HRTIMER_RESTART   | Periodic timer |

([EmbeTronicX][1])

---

# Initialize High Resolution Timer

## hrtimer_init()

```c
void hrtimer_init(
        struct hrtimer *timer,
        clockid_t clock_id,
        enum hrtimer_mode mode);
```

Parameters:

| Parameter | Description          |
| --------- | -------------------- |
| timer     | Timer object         |
| clock_id  | Clock source         |
| mode      | Relative or absolute |

Example:

```c
hrtimer_init(
        &etx_hr_timer,
        CLOCK_MONOTONIC,
        HRTIMER_MODE_REL);
```

([EmbeTronicX][1])

---

# Clock Sources

## CLOCK_MONOTONIC

```text
System Boot
      |
      +--> Time Always Increases
```

Never jumps backwards.

Most common choice for drivers.

---

## CLOCK_REALTIME

```text
Wall Clock Time
```

Affected by:

```text
date command
NTP adjustments
RTC updates
```

([EmbeTronicX][1])

---

# Timer Modes

## Relative Mode

```c
HRTIMER_MODE_REL
```

Timer expires:

```text
Current Time + Interval
```

Example:

```c
5 Seconds From Now
```

---

## Absolute Mode

```c
HRTIMER_MODE_ABS
```

Expires at a specific timestamp.

([EmbeTronicX][1])

---

# Assign Callback

After initialization:

```c
etx_hr_timer.function =
        &timer_callback;
```

Associates callback function with timer.

---

# Start Timer

## hrtimer_start()

```c
int hrtimer_start(
        struct hrtimer *timer,
        ktime_t time,
        enum hrtimer_mode mode);
```

Example:

```c
ktime_t ktime;

ktime = ktime_set(5, 0);

hrtimer_start(
        &etx_hr_timer,
        ktime,
        HRTIMER_MODE_REL);
```

Meaning:

```text
Fire After 5 Seconds
```

Returns:

| Value | Meaning              |
| ----- | -------------------- |
| 0     | Timer inactive       |
| 1     | Timer already active |

([EmbeTronicX][1])

---

# One-Shot Timer

```c
enum hrtimer_restart
timer_callback(
        struct hrtimer *timer)
{
    printk("Expired\n");

    return HRTIMER_NORESTART;
}
```

Execution:

```text
Start
   |
   v
Expire
   |
   v
Callback
   |
   v
Stop
```

---

# Periodic Timer

For periodic behavior:

```c
enum hrtimer_restart
timer_callback(
        struct hrtimer *timer)
{
    hrtimer_forward_now(
            timer,
            interval);

    return HRTIMER_RESTART;
}
```

Execution:

```text
Expire
   |
   v
Callback
   |
   v
Forward Timer
   |
   v
Restart
```

([EmbeTronicX][1])

---

# hrtimer_forward()

Move timer forward.

```c
u64 hrtimer_forward(
        struct hrtimer *timer,
        ktime_t now,
        ktime_t interval);
```

Used for periodic timers.

Returns:

```text
Overrun Count
```

([EmbeTronicX][1])

---

# hrtimer_forward_now()

Most common periodic timer API.

```c
u64 hrtimer_forward_now(
        struct hrtimer *timer,
        ktime_t interval);
```

Example:

```c
hrtimer_forward_now(
        timer,
        interval);
```

Schedules next expiration relative to current time. ([EmbeTronicX][1])

---

# Stop Timer

## hrtimer_cancel()

```c
int hrtimer_cancel(
        struct hrtimer *timer);
```

Behavior:

```text
Cancel Timer
Wait For Callback
Return
```

Returns:

| Value | Meaning        |
| ----- | -------------- |
| 0     | Timer inactive |
| 1     | Timer active   |

([EmbeTronicX][1])

---

# hrtimer_try_to_cancel()

```c
int hrtimer_try_to_cancel(
        struct hrtimer *timer);
```

Returns:

| Value | Meaning          |
| ----- | ---------------- |
| 1     | Stopped          |
| 0     | Not Active       |
| -1    | Callback Running |

([EmbeTronicX][1])

---

# Timer Status APIs

## hrtimer_get_remaining()

```c
ktime_t
hrtimer_get_remaining(
        const struct hrtimer *timer);
```

Returns remaining time.

---

## hrtimer_callback_running()

```c
int
hrtimer_callback_running(
        struct hrtimer *timer);
```

Returns:

```text
0 -> Not Running
1 -> Running
```

---

## hrtimer_cb_get_time()

```c
ktime_t
hrtimer_cb_get_time(
        struct hrtimer *timer);
```

Returns current timer time.

([EmbeTronicX][1])

---

# Example Driver Flow

## Initialization

```c
ktime_t ktime;

ktime =
    ktime_set(
        5,
        0);

hrtimer_init(
        &etx_hr_timer,
        CLOCK_MONOTONIC,
        HRTIMER_MODE_REL);

etx_hr_timer.function =
        &timer_callback;

hrtimer_start(
        &etx_hr_timer,
        ktime,
        HRTIMER_MODE_REL);
```

---

## Callback

```c
enum hrtimer_restart
timer_callback(
        struct hrtimer *timer)
{
    printk(
      "Timer Fired\n");

    hrtimer_forward_now(
            timer,
            interval);

    return HRTIMER_RESTART;
}
```

---

## Cleanup

```c
hrtimer_cancel(
        &etx_hr_timer);
```

---

# Execution Flow

```text
Module Load
      |
      v
hrtimer_init()
      |
      v
hrtimer_start()
      |
      v
Timer Expires
      |
      v
Callback
      |
      +--> HRTIMER_NORESTART
      |          |
      |          +--> Stop
      |
      +--> HRTIMER_RESTART
                 |
                 +--> Restart
```

---

# Callback Context

High-resolution timer callbacks execute in:

```text
SoftIRQ Context
```

Therefore:

### Allowed

```c
spin_lock();
atomic operations;
```

### Not Allowed

```c
msleep();
schedule();
mutex_lock();
copy_to_user();
```

Callbacks must be short and non-blocking. This design is part of why hrtimers are suitable for precision timing. ([EmbeTronicX][1])

---

# Kernel Timer vs HRTimer vs Workqueue

| Feature         | Kernel Timer | HRTimer     | Workqueue |
| --------------- | ------------ | ----------- | --------- |
| Resolution      | Jiffies      | Nanoseconds | N/A       |
| Context         | SoftIRQ      | SoftIRQ     | Process   |
| Sleep Allowed   | No           | No          | Yes       |
| Precision       | Low          | High        | N/A       |
| Long Processing | No           | No          | Yes       |

---

# Common Embedded Linux Use Cases

## Periodic Sensor Sampling

```text
100 us
   |
   +--> Read ADC
```

---

## Multimedia Synchronization

```text
Audio Frame
     |
     +--> Precise Playback
```

---

## Protocol Timing

```text
Industrial Bus
       |
       +--> Precise Timeout
```

---

## Motor Control

```text
Control Loop
      |
      +--> Accurate Period
```

---

# Important APIs Summary

## Time Creation

```c
ktime_set()
```

## Initialization

```c
hrtimer_init()
```

## Start

```c
hrtimer_start()
```

## Stop

```c
hrtimer_cancel()

hrtimer_try_to_cancel()
```

## Periodic Support

```c
hrtimer_forward()

hrtimer_forward_now()
```

## Status

```c
hrtimer_get_remaining()

hrtimer_callback_running()

hrtimer_cb_get_time()
```

---

# Key Takeaways

* High Resolution Timers provide **nanosecond-resolution timing**.
* They are not based on jiffies and are far more precise than traditional kernel timers.
* `ktime_t` is the primary time representation.
* `hrtimer_init()` initializes the timer.
* `hrtimer_start()` starts the timer.
* `hrtimer_cancel()` safely stops the timer.
* Returning `HRTIMER_RESTART` creates periodic behavior.
* Callbacks execute in SoftIRQ context and cannot sleep.
* HRTimers are commonly used in multimedia, real-time control, industrial automation, and precision driver timing. ([EmbeTronicX][1])

**Source:** EmbeTronicX Linux Device Driver Tutorial Part 27 – High Resolution Timer in Linux Device Driver. ([EmbeTronicX][1])

[1]: https://embetronicx.com/tutorials/linux/device-drivers/using-high-resolution-timer-in-linux-device-driver/?utm_source=chatgpt.com "High Resolution Timer - Linux Device Driver Tutorial Part 27"


## Conclusion
This is just a basic linux device driver which explains about the kernel timer in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/using-high-resolution-timer-in-linux-device-driver/
