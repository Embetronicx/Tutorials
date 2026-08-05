# Linux Device Driver - EXPORT_SYMBOL in Linux Kernel

## Overview

`EXPORT_SYMBOL()` is a Linux kernel macro used to make a function or variable available to other loadable kernel modules. Without exporting a symbol, it remains private to the module where it is defined. ([EmbeTronicX][1])

Think of it as:

```text
Driver A
   |
   +--> Function
   +--> Variable
   |
   +--> EXPORT_SYMBOL()
           |
           v
Kernel Symbol Table
           |
           v
Driver B Can Access It
```

---

# What is a Symbol?

In Linux kernel terminology, a symbol is:

* Function name
* Global variable
* Data structure instance

Examples:

```c
int device_count;

void device_init(void);
```

Both are symbols.

A symbol represents a named location in memory containing either:

```text
Data      -> Variables
Code      -> Functions
```

([EmbeTronicX][1])

---

# Why EXPORT_SYMBOL?

Suppose we have two drivers:

```text
Driver1
    |
    +--> Common Function
    +--> Shared Variable

Driver2
    |
    +--> Wants To Use Them
```

Without exporting:

```text
Driver2
   |
   +--> Unknown Symbol Error
```

With exporting:

```text
Driver1
   |
   +--> EXPORT_SYMBOL()

Driver2
   |
   +--> Access Allowed
```

This enables inter-module communication without modifying kernel source code. ([EmbeTronicX][1])

---

# Historical Background

## Linux 2.4

All non-static symbols were exported automatically.

```text
Global Function
      |
      +--> Visible Everywhere
```

---

## Linux 2.6 and Later

Only explicitly exported symbols are visible.

```text
Function
    |
    +--> EXPORT_SYMBOL()
             |
             +--> Visible
```

Otherwise:

```text
Private Symbol
```

This reduced unnecessary symbol exposure. ([EmbeTronicX][1])

---

# EXPORT_SYMBOL Architecture

```text
Driver1
   |
   +--> Function
   |
   +--> EXPORT_SYMBOL()
            |
            v
     Kernel Symbol Table
            |
            v
Driver2
   |
   +--> extern Declaration
   |
   +--> Function Call
```

---

# Basic Syntax

## Export Function

```c
void shared_function(void)
{
    pr_info("Hello\n");
}

EXPORT_SYMBOL(shared_function);
```

---

## Export Variable

```c
int device_count = 0;

EXPORT_SYMBOL(device_count);
```

This makes both symbols available to other modules. ([EmbeTronicX][1])

---

# Exporting Functions

## Provider Module

```c
void etx_shared_func(void)
{
    pr_info("Shared function called\n");
}

EXPORT_SYMBOL(etx_shared_func);
```

---

## Consumer Module

```c
void etx_shared_func(void);

etx_shared_func();
```

Execution:

```text
Consumer Module
      |
      +--> Calls Function
      |
      v
Provider Module
      |
      +--> Function Executes
```

([EmbeTronicX][1])

---

# Exporting Variables

## Provider

```c
int etx_count = 0;

EXPORT_SYMBOL(etx_count);
```

---

## Consumer

```c
extern int etx_count;

pr_info("%d\n", etx_count);
```

Execution:

```text
Provider
    |
    +--> etx_count

Consumer
    |
    +--> Read/Modify etx_count
```

([EmbeTronicX][1])

---

# Example Architecture

```text
+------------------+
|    Driver 1      |
+------------------+
| etx_shared_func  |
| etx_count        |
+------------------+
         |
         |
EXPORT_SYMBOL()
         |
         v
+------------------+
| Kernel Symbol    |
|     Table        |
+------------------+
         |
         |
         v
+------------------+
|    Driver 2      |
+------------------+
| Uses Function    |
| Uses Variable    |
+------------------+
```

---

# Example Provider Driver

## Shared Variable

```c
int etx_count = 0;
```

---

## Shared Function

```c
void etx_shared_func(void)
{
    pr_info("Shared function called\n");

    etx_count++;
}
```

---

## Export Symbols

```c
EXPORT_SYMBOL(etx_shared_func);

EXPORT_SYMBOL(etx_count);
```

Now both become globally visible to loadable modules. ([EmbeTronicX][1])

---

# Example Consumer Driver

## Import Variable

```c
extern int etx_count;
```

---

## Import Function

```c
void etx_shared_func(void);
```

---

## Use Them

```c
etx_shared_func();

pr_info("%d\n", etx_count);
```

Execution:

```text
Read Device
      |
      +--> Shared Function
      |
      +--> Increment Counter
      |
      +--> Print Counter
```

([EmbeTronicX][1])

---

# Module Loading Order

This is extremely important.

Correct:

```text
insmod driver1.ko

insmod driver2.ko
```

Because:

```text
Driver1
   |
   +--> Defines Symbol

Driver2
   |
   +--> Uses Symbol
```

---

Wrong:

```text
insmod driver2.ko
```

Error:

```text
Unknown symbol
```

Because the symbol does not exist in the kernel symbol table yet. ([EmbeTronicX][1])

---

# Module Unloading Order

Correct:

```text
rmmod driver2

rmmod driver1
```

Wrong:

```text
rmmod driver1
```

while driver2 is using it.

Error:

```text
Module in use
```

([EmbeTronicX][1])

---

# Module.symvers

After compilation:

```bash
make
```

Kernel generates:

```text
Module.symvers
```

Example:

```text
0x1db7034a etx_shared_func EXPORT_SYMBOL

0x6dcb135c etx_count EXPORT_SYMBOL
```

This file records exported symbols and version information. ([EmbeTronicX][1])

---

# Checking Exported Symbols

## Using kallsyms

```bash
cat /proc/kallsyms | grep etx_shared_func
```

or

```bash
cat /proc/kallsyms | grep etx_count
```

If visible:

```text
Symbol Successfully Exported
```

([EmbeTronicX][1])

---

# EXPORT_SYMBOL_GPL

Linux also provides:

```c
EXPORT_SYMBOL_GPL(symbol);
```

Difference:

| Macro             | Accessible By    |
| ----------------- | ---------------- |
| EXPORT_SYMBOL     | Any Module       |
| EXPORT_SYMBOL_GPL | GPL Modules Only |

Example:

```c
EXPORT_SYMBOL_GPL(my_func);
```

Only GPL licensed modules can use it. ([EmbeTronicX][1])

---

# EXPORT_SYMBOL vs EXPORT_SYMBOL_GPL

| Feature            | EXPORT_SYMBOL | EXPORT_SYMBOL_GPL    |
| ------------------ | ------------- | -------------------- |
| GPL Module         | Yes           | Yes                  |
| Proprietary Module | Yes           | No                   |
| Kernel Enforcement | Normal        | GPL Only             |
| Common Usage       | Generic APIs  | Internal Kernel APIs |

---

# Limitations

## Cannot Export Static Symbols

Wrong:

```c
static int count;

EXPORT_SYMBOL(count);
```

Reason:

```text
static
    |
    +--> File Scope Only
```

Exported symbols must have global visibility. ([EmbeTronicX][1])

---

## Avoid Inline Functions

Wrong:

```c
inline void my_func(void)
{
}
```

```c
EXPORT_SYMBOL(my_func);
```

Inline functions may not generate a standalone symbol. ([EmbeTronicX][1])

---

# Execution Flow

```text
Load Driver1
      |
      v
Export Symbols
      |
      v
Kernel Symbol Table
      |
      v
Load Driver2
      |
      v
Resolve Symbols
      |
      v
Driver2 Uses Them
```

---

# Common Use Cases

## Shared Utility Functions

```text
Driver A
      |
      +--> CRC Calculation

Driver B
      |
      +--> Reuse Same Function
```

---

## Shared Device State

```text
Driver A
      |
      +--> Device Status

Driver B
      |
      +--> Read Status
```

---

## Common Hardware Layer

```text
GPIO Driver
      |
      +--> Export API

Other Drivers
      |
      +--> Use API
```

---

## Platform Frameworks

```text
Core Driver
      |
      +--> Export Services

Child Drivers
      |
      +--> Consume Services
```

---

# Common Errors

## Unknown Symbol

```text
insmod: ERROR:
Unknown symbol
```

Possible reasons:

* Provider module not loaded
* Symbol not exported
* Name mismatch

---

## Static Symbol Export

Wrong:

```c
static int value;

EXPORT_SYMBOL(value);
```

---

## Missing extern

Wrong:

```c
int etx_count;
```

Correct:

```c
extern int etx_count;
```

---

# EXPORT_SYMBOL vs Header Files

Many beginners ask:

```text
Why not just include a header?
```

Header files provide:

```text
Declaration
```

EXPORT_SYMBOL provides:

```text
Kernel Module Linkage
```

Both are required.

```text
Header File
      |
      +--> Compiler Knows Symbol

EXPORT_SYMBOL
      |
      +--> Kernel Loader Resolves Symbol
```

([Reddit][2])

---

# Important APIs Summary

## Export

```c
EXPORT_SYMBOL()

EXPORT_SYMBOL_GPL()
```

---

## Import

```c
extern variable;

function declaration;
```

---

## Verification

```bash
cat /proc/kallsyms

cat Module.symvers
```

---

# Key Takeaways

* `EXPORT_SYMBOL()` exposes functions or variables to other kernel modules.
* Only exported symbols can be resolved by loadable modules.
* Provider module must be loaded before consumer module.
* Exported symbols appear in the kernel symbol table.
* `EXPORT_SYMBOL_GPL()` restricts usage to GPL-licensed modules.
* Symbols should not be `static` or `inline`.
* `Module.symvers` records exported symbol information.
* Commonly used for sharing APIs, utility functions, hardware abstraction layers, and global state between kernel modules. ([EmbeTronicX][1])

**Source:** EmbeTronicX Linux Device Driver Tutorial Part 29 – EXPORT_SYMBOL in Linux Device Driver. ([EmbeTronicX][1])

[1]: https://embetronicx.com/tutorials/linux/device-drivers/export_symbol-in-linux-device-driver/?utm_source=chatgpt.com "EXPORT_SYMBOL in Linux Kernel - Linux Device Driver Part 29"
[2]: https://www.reddit.com/r/kernel/comments/180ktd8?utm_source=chatgpt.com "Why do we need the EXPORT_SYMBOL() macro?"


## Conclusion
This is just a basic linux device driver which explains about the EXPORT_SYMBOL in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/export_symbol-in-linux-device-driver/
