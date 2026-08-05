# Linux Device Driver - Atomic Variables and Atomic Operations in Linux Kernel

## Overview

Atomic operations provide a way to safely manipulate shared integer variables without using mutexes or spinlocks.

The operation is performed as a single indivisible action, preventing race conditions when multiple CPUs, threads, or interrupt handlers access the same variable simultaneously. ([EmbeTronicX][1])

---

# Why Atomic Variables?

Consider a shared variable:

```c
int counter = 0;
```

Two threads execute:

```c
counter++;
```

Internally this is not a single operation:

```text
1. Read counter
2. Increment value
3. Write back counter
```

Possible execution:

```text
Thread1 reads 0
Thread2 reads 0

Thread1 writes 1
Thread2 writes 1
```

Expected:

```text
counter = 2
```

Actual:

```text
counter = 1
```

This is a race condition. ([EmbeTronicX][1])

---

# Traditional Solution

Using a mutex:

```c
mutex_lock(&lock);

counter++;

mutex_unlock(&lock);
```

or spinlock:

```c
spin_lock(&lock);

counter++;

spin_unlock(&lock);
```

Works correctly but introduces synchronization overhead. ([EmbeTronicX][1])

---

# Atomic Solution

Use an atomic variable:

```c
atomic_t counter = ATOMIC_INIT(0);

atomic_inc(&counter);
```

Internally:

```text
Read + Modify + Write
        |
        +--> One Atomic Operation
```

No additional lock required. ([EmbeTronicX][1])

---

# What Does "Atomic" Mean?

Atomic means:

```text
Indivisible
```

An operation either:

```text
Completes Entirely
        OR
Does Not Happen
```

No other CPU can observe a partially completed atomic operation. ([Reddit][2])

---

# When Should Atomic Variables Be Used?

Good candidates:

```text
Reference Counters
Packet Counters
Statistics
Flags
Device Usage Count
Simple Shared Integers
```

Example:

```c
atomic_t packet_count;
```

---

# When NOT To Use Atomic Variables

Bad candidates:

```text
Complex Data Structures
Linked Lists
Multiple Variables
Large Critical Sections
```

Use:

```text
Mutex
Spinlock
RW Spinlock
RCU
```

instead.

---

# Atomic Variable Types

Linux provides two primary atomic integer types.

---

## atomic_t

Stores a 32-bit integer.

```c
atomic_t counter;
```

Kernel definition conceptually:

```c
typedef struct {
    int counter;
} atomic_t;
```

([EmbeTronicX][1])

---

## atomic64_t

Stores a 64-bit integer.

```c
atomic64_t counter64;
```

Conceptually:

```c
typedef struct {
    long counter;
} atomic64_t;
```

Available on supported architectures. ([EmbeTronicX][1])

---

# Header Files

```c
#include <linux/atomic.h>
```

Older kernels may use:

```c
#include <asm/atomic.h>
```

([EmbeTronicX][1])

---

# Creating Atomic Variables

## Method 1

Declaration only:

```c
atomic_t etx_counter;
```

Must initialize later.

---

## Method 2

Initialize during declaration:

```c
atomic_t etx_counter =
        ATOMIC_INIT(0);
```

Creates:

```text
Atomic Integer
Initial Value = 0
```

([EmbeTronicX][1])

---

# Reading Atomic Variables

## atomic_read()

Reads the atomic variable.

```c
int value;

value = atomic_read(
            &etx_counter);
```

Example:

```c
pr_info(
    "Value=%d\n",
    atomic_read(
        &etx_counter));
```

Returns current value. ([EmbeTronicX][1])

---

# Writing Atomic Variables

## atomic_set()

Assign value atomically.

```c
atomic_set(
        &etx_counter,
        10);
```

Result:

```text
etx_counter = 10
```

([EmbeTronicX][1])

---

# Atomic Arithmetic Operations

---

## atomic_inc()

Increment by one.

```c
atomic_inc(
        &etx_counter);
```

Equivalent:

```c
counter++;
```

but atomic. ([EmbeTronicX][1])

---

## atomic_dec()

Decrement by one.

```c
atomic_dec(
        &etx_counter);
```

Equivalent:

```c
counter--;
```

but atomic. ([EmbeTronicX][1])

---

## atomic_add()

Add value.

```c
atomic_add(
        5,
        &etx_counter);
```

Result:

```text
counter += 5
```

([EmbeTronicX][1])

---

## atomic_sub()

Subtract value.

```c
atomic_sub(
        5,
        &etx_counter);
```

Result:

```text
counter -= 5
```

([EmbeTronicX][1])

---

# Test Operations

Useful when checking conditions immediately after modification.

---

## atomic_inc_and_test()

```c
if (atomic_inc_and_test(
        &counter))
{
}
```

Returns:

```text
true  -> Result became 0
false -> Otherwise
```

([EmbeTronicX][1])

---

## atomic_dec_and_test()

```c
if (atomic_dec_and_test(
        &counter))
{
}
```

Returns:

```text
true -> Counter reached 0
```

Commonly used in reference counting. ([EmbeTronicX][1])

---

## atomic_sub_and_test()

```c
if (atomic_sub_and_test(
        5,
        &counter))
{
}
```

Returns:

```text
true -> Result equals 0
```

([EmbeTronicX][1])

---

# Return Value Operations

---

## atomic_add_return()

```c
int value;

value =
    atomic_add_return(
        5,
        &counter);
```

Returns:

```text
New Value After Addition
```

Example:

```text
counter = 10

atomic_add_return(5)

returns 15
```

([EmbeTronicX][1])

---

## atomic_inc_return()

```c
value =
    atomic_inc_return(
        &counter);
```

Returns incremented value.

---

## atomic_dec_return()

```c
value =
    atomic_dec_return(
        &counter);
```

Returns decremented value.

---

# Conditional Atomic Operations

## atomic_add_unless()

```c
atomic_add_unless(
        &counter,
        1,
        100);
```

Meaning:

```text
Add 1
Unless Value == 100
```

Useful for reference counting. ([EmbeTronicX][1])

---

# Atomic Bit Operations

Linux also supports atomic operations on individual bits.

Example:

```c
unsigned long flags;
```

---

## set_bit()

```c
set_bit(
        0,
        &flags);
```

Set bit 0.

---

## clear_bit()

```c
clear_bit(
        0,
        &flags);
```

Clear bit 0.

---

## test_bit()

```c
if(test_bit(
        0,
        &flags))
{
}
```

Check bit.

---

## test_and_set_bit()

```c
old =
test_and_set_bit(
        0,
        &flags);
```

Returns previous value and sets bit atomically. ([EmbeTronicX][1])

---

# Example Driver

## Atomic Variable

```c
atomic_t etx_counter =
        ATOMIC_INIT(0);
```

---

## Thread 1

```c
while(!kthread_should_stop())
{
    atomic_inc(
            &etx_counter);

    pr_info(
      "Thread1=%d\n",
      atomic_read(
        &etx_counter));

    msleep(1000);
}
```

---

## Thread 2

```c
while(!kthread_should_stop())
{
    atomic_inc(
            &etx_counter);

    pr_info(
      "Thread2=%d\n",
      atomic_read(
        &etx_counter));

    msleep(1000);
}
```

Both threads update the same variable safely without locks. ([EmbeTronicX][1])

---

# Execution Flow

```text
Thread1
    |
    +--> atomic_inc()

Thread2
    |
    +--> atomic_inc()

CPU Guarantees
Atomic Update
```

Result:

```text
0
1
2
3
4
5
...
```

No lost updates.

---

# Atomic Variable vs Mutex

| Feature          | Atomic Variable | Mutex    |
| ---------------- | --------------- | -------- |
| Single Integer   | Excellent       | Overkill |
| Sleep            | No              | Yes      |
| Ownership        | No              | Yes      |
| Critical Section | No              | Yes      |
| Performance      | Very High       | Lower    |
| ISR Safe         | Yes             | No       |

([EmbeTronicX][1])

---

# Atomic Variable vs Spinlock

| Feature            | Atomic    | Spinlock  |
| ------------------ | --------- | --------- |
| Single Variable    | Excellent | Overkill  |
| Multiple Variables | Poor      | Excellent |
| Locking Required   | No        | Yes       |
| Complexity         | Low       | Medium    |
| Performance        | Higher    | Lower     |

([EmbeTronicX][1])

---

# Common Driver Use Cases

## Packet Counter

```c
atomic_t rx_packets;
```

```c
atomic_inc(
        &rx_packets);
```

---

## Open Count

```c
atomic_t open_count;
```

```c
atomic_inc(
        &open_count);

atomic_dec(
        &open_count);
```

---

## Reference Counter

```c
atomic_t refcount;
```

```c
if (atomic_dec_and_test(
        &refcount))
{
    free_resource();
}
```

---

## Device State Flags

```c
set_bit(0, &flags);
clear_bit(0, &flags);
```

---

# Common Mistakes

## Using Atomic Variable for Complex Logic

Wrong:

```c
if(counter == 0)
{
    counter++;
}
```

Race possible.

Use:

```c
atomic operations
or
locks
```

---

## Protecting Multiple Variables

Wrong:

```c
atomic_t a;
atomic_t b;
```

Need consistency between both.

Use:

```c
spinlock
mutex
```

instead.

---

## Sleeping Assumption

Atomic operations:

```text
Do NOT Sleep
Do NOT Block
```

They only guarantee atomic access to the variable.

---

# Important APIs Summary

## Declaration

```c
atomic_t
atomic64_t
ATOMIC_INIT()
```

---

## Read / Write

```c
atomic_read()

atomic_set()
```

---

## Arithmetic

```c
atomic_inc()

atomic_dec()

atomic_add()

atomic_sub()
```

---

## Test Operations

```c
atomic_inc_and_test()

atomic_dec_and_test()

atomic_sub_and_test()
```

---

## Return Operations

```c
atomic_add_return()

atomic_inc_return()

atomic_dec_return()
```

---

## Conditional

```c
atomic_add_unless()
```

---

## Bit Operations

```c
set_bit()

clear_bit()

test_bit()

test_and_set_bit()
```

---

# Key Takeaways

* Atomic operations provide lock-free synchronization for simple integer and bit variables.
* `atomic_t` is used for 32-bit atomic integers; `atomic64_t` for 64-bit values.
* Atomic operations prevent race conditions without mutexes or spinlocks.
* They are ideal for counters, flags, statistics, and reference counts.
* Atomic variables are not a replacement for mutexes or spinlocks when protecting complex data structures.
* Use atomic operations when the shared resource is a single integer or bit field and performance is important. ([EmbeTronicX][1])

[1]: https://embetronicx.com/tutorials/linux/device-drivers/atomic-variables-atomic-operation/?utm_source=chatgpt.com "Atomic variable in Linux - Linux Device Driver Tutorial Part 30"
[2]: https://www.reddit.com/r/linux/comments/1dxdfoy?utm_source=chatgpt.com "Linux 6.11 To Introduce Block Atomic Writes - Including NVMe & SCSI Support"


## Conclusion
This is just a basic linux device driver which explains about the atomic variables in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/atomic-variables-atomic-operation/
