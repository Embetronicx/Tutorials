# Linux Device Driver - Sending Signal from Kernel Driver to User Space

## Overview

Signals are one of the oldest Inter-Process Communication (IPC) mechanisms in Linux.

They are used to notify a process that a specific event has occurred.

Examples:

```text
ATM Transaction
      |
      +--> SMS Notification

Microwave Finished
      |
      +--> Beep Sound

Linux Driver Event
      |
      +--> Signal To User Application
```

Linux drivers can send signals directly to user-space applications whenever an event occurs, such as:

* Hardware interrupt
* GPIO event
* DMA completion
* Sensor threshold crossing
* Device error
* Data ready notification

The EmbeTronicX example demonstrates sending a signal from a device driver to a user-space application when an interrupt occurs.

---

# What is a Signal?

A signal is an asynchronous notification sent to a process or thread.

Examples of standard Linux signals:

| Signal  | Description        |
| ------- | ------------------ |
| SIGINT  | Ctrl+C             |
| SIGKILL | Kill process       |
| SIGTERM | Terminate          |
| SIGSEGV | Segmentation fault |
| SIGUSR1 | User-defined       |
| SIGUSR2 | User-defined       |

The tutorial uses a custom signal:

```c
#define SIGETX 44
```

Signal number 44 is used to notify the application from the driver.

---

# Driver to User Communication Flow

```text
User Application
        |
        | Register PID
        v
Device Driver
        |
        | Interrupt Occurs
        v
Interrupt Handler
        |
        | send_sig_info()
        v
Linux Signal Subsystem
        |
        v
Signal Handler
        |
        v
User Application
```

---

# Steps Involved

To send a signal from kernel space to user space:

```text
1. Select Signal Number

2. Register Application

3. Save Process Information

4. Event Occurs

5. Driver Sends Signal

6. User Application Handles Signal
```

---

# Step 1 - Select Signal Number

Choose a signal number.

Example:

```c
#define SIGETX 44
```

This signal will be delivered to the application whenever the event occurs.

---

# Step 2 - Register User Application

Before sending a signal, the driver must know:

```text
Which Process Should Receive It?
```

The application registers itself using:

```text
IOCTL
```

Application:

```c
ioctl(
    fd,
    REG_CURRENT_TASK,
    &number);
```

Driver:

```c
#define REG_CURRENT_TASK \
        _IOW('a','a',int32_t *)
```

---

# Step 3 - Save Process Information

The driver stores the current task.

```c
static struct task_struct *task = NULL;
```

Inside IOCTL:

```c
task = get_current();
```

This returns:

```text
Current User Process
```

Kernel now knows where to send the signal.

---

# Driver Registration Code

```c
static long etx_ioctl(
        struct file *file,
        unsigned int cmd,
        unsigned long arg)
{
    if(cmd == REG_CURRENT_TASK)
    {
        task = get_current();

        signum = SIGETX;
    }

    return 0;
}
```

Purpose:

```text
Store User Process Context
```

---

# Event Trigger

In the example:

```text
Read Device File
      |
      v
Software Interrupt
      |
      v
Interrupt Handler
      |
      v
Send Signal
```

Driver read function:

```c
static ssize_t etx_read(...)
{
    asm("int $0x3B");

    return 0;
}
```

This generates IRQ 11.

---

# Interrupt Handler

When interrupt occurs:

```c
static irqreturn_t
irq_handler(
        int irq,
        void *dev_id)
{
    ...
}
```

Purpose:

```text
Prepare Signal Information
```

---

# Signal Information Structure

Kernel uses:

```c
struct siginfo info;
```

Initialize:

```c
memset(
        &info,
        0,
        sizeof(info));
```

Fill fields:

```c
info.si_signo = SIGETX;

info.si_code = SI_QUEUE;

info.si_int = 1;
```

Meaning:

| Field    | Description            |
| -------- | ---------------------- |
| si_signo | Signal number          |
| si_code  | Signal source          |
| si_int   | Custom integer payload |

---

# Sending Signal

Core API:

```c
send_sig_info(
        SIGETX,
        &info,
        task);
```

Example:

```c
if(task != NULL)
{
    send_sig_info(
            SIGETX,
            &info,
            task);
}
```

Parameters:

| Parameter | Description    |
| --------- | -------------- |
| SIGETX    | Signal number  |
| &info     | Signal payload |
| task      | Target process |

---

# Driver Side Flow

```text
IRQ Occurs
    |
    v
Create siginfo
    |
    v
Fill Data
    |
    v
send_sig_info()
    |
    v
Signal Delivered
```

---

# User Space Signal Handler

Application installs handler:

```c
struct sigaction act;
```

Register:

```c
act.sa_flags = SA_SIGINFO;

act.sa_sigaction =
        sig_event_handler;

sigaction(
        SIGETX,
        &act,
        NULL);
```

---

# Signal Callback

```c
void sig_event_handler(
        int n,
        siginfo_t *info,
        void *unused)
{
    if(n == SIGETX)
    {
        check = info->si_int;

        printf(
          "Received signal\n");
    }
}
```

This function executes automatically when the signal arrives.

---

# Passing Data with Signal

Driver:

```c
info.si_int = 1;
```

User Space:

```c
check = info->si_int;
```

Output:

```text
Received signal from kernel
Value = 1
```

This allows small event data to accompany the signal.

---

# Complete Execution Flow

```text
Application Starts
        |
        v
Open Device
        |
        v
IOCTL Registration
        |
        v
Driver Stores Task
        |
        v
Waiting...
        |
        v
Interrupt Occurs
        |
        v
ISR Executes
        |
        v
send_sig_info()
        |
        v
Signal Arrives
        |
        v
Signal Handler Executes
```

---

# Sample Application Output

```text
Installed signal handler
for SIGETX = 44

Opening Driver

Registering application...
Done!!!

Waiting for signal...
```

After interrupt:

```text
Received signal
from kernel : Value = 1
```

---

# Sample Driver Logs

```text
Device Driver Insert...Done!!!

REG_CURRENT_TASK

Read Function

Shared IRQ:
Interrupt Occurred

Sending signal to app
```

This confirms:

```text
Application Registered

Interrupt Triggered

Signal Sent Successfully
```

---

# Common Use Cases

## GPIO Interrupt

```text
Button Pressed
      |
      +--> Signal Application
```

---

## Sensor Threshold

```text
Temperature > Limit
         |
         +--> Notify User Space
```

---

## DMA Completion

```text
DMA Transfer Done
         |
         +--> Signal Process
```

---

## Data Ready

```text
UART Data Available
          |
          +--> Signal Reader
```

---

## Hardware Error

```text
Device Fault
      |
      +--> Alert Application
```

---

# Advantages

* Simple implementation
* Low overhead
* Asynchronous notification
* Fast event delivery
* No polling required

---

# Limitations

Signals are best for:

```text
Notification
```

Not for:

```text
Large Data Transfer
```

Bad use case:

```text
Send 1 KB Data
```

Good use case:

```text
Data Ready
Go Read It
```

For large transfers use:

* read()
* mmap()
* Netlink
* Shared Memory
* Character Device Buffers

---

# Signal vs Polling

| Feature         | Signal | Polling              |
| --------------- | ------ | -------------------- |
| CPU Usage       | Low    | High                 |
| Latency         | Low    | Depends on Poll Rate |
| Event Driven    | Yes    | No                   |
| Power Efficient | Yes    | No                   |

---

# Signal vs Netlink

| Feature             | Signal    | Netlink   |
| ------------------- | --------- | --------- |
| Simple Notification | Excellent | Good      |
| Large Data          | Poor      | Excellent |
| Bidirectional       | Limited   | Yes       |
| Structured Messages | No        | Yes       |

---

# Important APIs Summary

## Driver Side

```c
get_current()

send_sig_info()
```

---

## Signal Information

```c
struct siginfo
```

---

## User Space

```c
sigaction()
```

---

## Registration

```c
ioctl()
```

---

# Key Takeaways

* Linux signals provide asynchronous notifications between kernel and user space.
* The user application must register itself with the driver first.
* The driver stores the application's `task_struct`.
* `send_sig_info()` is the primary kernel API used to send signals.
* `struct siginfo` can carry small payload data.
* Signal handlers are registered using `sigaction()`.
* Signals are ideal for event notification but not for large data transfer.
* Common embedded Linux use cases include GPIO interrupts, DMA completion, sensor events, and hardware fault notifications.
* A signal-based design avoids inefficient polling loops and provides immediate event notification.


## Conclusion
This is just a basic linux device driver which explains send signals from kernel to userspace.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/sending-signal-from-linux-device-driver-to-user-space/
