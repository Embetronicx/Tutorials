# Linux Device Driver - Wait Queue

## Overview

A Wait Queue is a Linux kernel synchronization mechanism used when a process or kernel thread needs to sleep until a specific event occurs.

Instead of continuously polling for an event, the task can:

1. Sleep (block)
2. Release CPU resources
3. Wake up when the event occurs

This improves CPU utilization and system efficiency.

---

## Why Wait Queue?

In Linux device drivers, a process may need to wait for:

- Data arrival
- Hardware interrupt
- Completion of an operation
- Event notification from another thread

Wait Queues provide a safe mechanism to:

- Put tasks into sleep state
- Wake them when the required condition becomes true

---

## Wait Queue Workflow

```text
Initialize Wait Queue
         |
         v
Put Task To Sleep
(wait_event...)
         |
         v
Event Occurs
         |
         v
Wake Up Task
(wake_up...)
         |
         v
Task Continues Execution
```

---

## Header File

```c
#include <linux/wait.h>
```

---

# Step 1: Initialize Wait Queue

There are two methods.

## Static Initialization

```c
DECLARE_WAIT_QUEUE_HEAD(wq);
```

### Example

```c
DECLARE_WAIT_QUEUE_HEAD(my_waitqueue);
```

---

## Dynamic Initialization

```c
wait_queue_head_t wq;

init_waitqueue_head(&wq);
```

### Example

```c
wait_queue_head_t my_waitqueue;

init_waitqueue_head(&my_waitqueue);
```

---

# Step 2: Put Task To Sleep

Linux provides several macros.

---

## wait_event()

Sleep until condition becomes true.

```c
wait_event(wq, condition);
```

### State

```text
TASK_UNINTERRUPTIBLE
```

### Example

```c
wait_event(my_waitqueue, data_ready);
```

---

## wait_event_timeout()

Sleep until:

- Condition becomes true
OR
- Timeout expires

```c
wait_event_timeout(wq, condition, timeout);
```

### Example

```c
wait_event_timeout(my_waitqueue,
                   data_ready,
                   msecs_to_jiffies(5000));
```

### Returns

| Return Value | Meaning |
|-------------|----------|
| 0 | Timeout occurred |
| >0 | Remaining jiffies |
| 1 | Condition became true after timeout |

---

## wait_event_cmd()

Execute commands before and after sleep.

```c
wait_event_cmd(wq,
               condition,
               cmd1,
               cmd2);
```

### Example

```c
wait_event_cmd(my_waitqueue,
               data_ready,
               printk("Before Sleep\n"),
               printk("After Wakeup\n"));
```

---

## wait_event_interruptible()

Sleep until:

- Condition becomes true
OR
- Signal arrives

```c
wait_event_interruptible(wq, condition);
```

### State

```text
TASK_INTERRUPTIBLE
```

### Returns

| Return Value | Meaning |
|-------------|----------|
| 0 | Condition became true |
| -ERESTARTSYS | Interrupted by signal |

---

## wait_event_interruptible_timeout()

Combination of:

- Interruptible sleep
- Timeout

```c
wait_event_interruptible_timeout(
        wq,
        condition,
        timeout);
```

### Returns

| Return Value | Meaning |
|-------------|----------|
| 0 | Timeout |
| >0 | Remaining jiffies |
| -ERESTARTSYS | Interrupted by signal |

---

## wait_event_killable()

Sleep until:

- Condition becomes true
OR
- Fatal signal received

```c
wait_event_killable(wq, condition);
```

### State

```text
TASK_KILLABLE
```

---

# Step 3: Wake Up Sleeping Tasks

When the event occurs, sleeping tasks must be awakened.

---

## wake_up()

Wake one task sleeping in uninterruptible state.

```c
wake_up(&wq);
```

### Example

```c
wake_up(&my_waitqueue);
```

---

## wake_up_all()

Wake all tasks in the wait queue.

```c
wake_up_all(&wq);
```

---

## wake_up_interruptible()

Wake one task sleeping in interruptible state.

```c
wake_up_interruptible(&wq);
```

---

## wake_up_sync()

Wake task without immediately rescheduling CPU.

```c
wake_up_sync(&wq);
```

---

## wake_up_interruptible_sync()

Interruptible version of wake_up_sync().

```c
wake_up_interruptible_sync(&wq);
```

---

# Common Driver Usage

## Waiting Thread

```c
while (1)
{
    wait_event_interruptible(
            my_waitqueue,
            event_flag != 0);

    if(event_flag == EXIT_EVENT)
        break;

    printk("Event Received\n");

    event_flag = 0;
}
```

---

## Event Producer

```c
event_flag = 1;

wake_up_interruptible(&my_waitqueue);
```

---

# Driver Flow Example

```text
Kernel Thread Started
         |
         v
Waiting For Event
         |
         v
User Reads Device
         |
         v
Driver Sets Flag
         |
         v
wake_up_interruptible()
         |
         v
Thread Wakes Up
         |
         v
Processes Event
         |
         v
Wait Again
```

---

# Important Sleep States

| State | Description |
|---------|-------------|
| TASK_RUNNING | Executing |
| TASK_INTERRUPTIBLE | Can be interrupted by signals |
| TASK_UNINTERRUPTIBLE | Cannot be interrupted |
| TASK_KILLABLE | Interrupted only by fatal signals |

---

# Advantages

- Efficient CPU usage
- No busy waiting
- Event-driven synchronization
- Commonly used in device drivers
- Works well with kernel threads

---

# Typical Driver Use Cases

- Blocking read()
- Interrupt handling
- Data arrival notification
- Producer-consumer synchronization
- Driver event notification
- Hardware completion events

---

# Wait Queue vs Busy Waiting

| Wait Queue | Busy Waiting |
|------------|-------------|
| Sleeps task | Continuously polls |
| CPU efficient | CPU wastage |
| Event driven | Polling driven |
| Preferred in kernel | Generally avoided |

---

# Important APIs Summary

## Initialization

```c
DECLARE_WAIT_QUEUE_HEAD(wq);

wait_queue_head_t wq;
init_waitqueue_head(&wq);
```

## Sleep

```c
wait_event()
wait_event_timeout()
wait_event_cmd()
wait_event_interruptible()
wait_event_interruptible_timeout()
wait_event_killable()
```

## Wake Up

```c
wake_up()
wake_up_all()
wake_up_interruptible()
wake_up_sync()
wake_up_interruptible_sync()
```

---

# Key Takeaways

- Wait Queue is a kernel mechanism for sleeping and waking tasks.
- A task sleeps until a condition becomes true.
- Sleeping tasks consume no CPU.
- Another task, ISR, or driver function wakes the waiting task.
- Frequently used in Linux device drivers for blocking operations and event synchronization.

## Conclusion
This is just a basic linux device driver. This will explain waitqueue in the linux device driver.

Please refer this URL for the complete tutorial of this source code.
https://embetronicx.com/tutorials/linux/device-drivers/waitqueue-in-linux-device-driver-tutorial/
