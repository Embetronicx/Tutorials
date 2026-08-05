# Linux Device Driver - Linked List in Linux Kernel

## Overview

The Linux kernel provides a built-in implementation of a **circular doubly linked list**.

Instead of implementing custom linked list structures, kernel developers use:

```c
#include <linux/list.h>
```

Benefits:

* Reusable kernel implementation
* Efficient insertion and deletion
* Widely used throughout kernel subsystems
* Supports dynamic data structures

---

# What is a Linked List?

A linked list consists of nodes connected using pointers.

Traditional implementation:

```c
struct my_node
{
    int data;

    struct my_node *prev;
    struct my_node *next;
};
```

Kernel implementation embeds a `list_head` structure.

```c
struct my_node
{
    struct list_head list;

    int data;
};
```

---

# Linux Kernel Linked List

Linux uses a **Circular Doubly Linked List**.

```text
+------+     +------+     +------+
|Node1 |<--->|Node2 |<--->|Node3 |
+------+     +------+     +------+
    ^                           |
    |___________________________|
```

Characteristics:

* Circular
* Doubly linked
* No NULL termination
* Head node always exists

---

# Header File

```c
#include <linux/list.h>
```

Kernel implementation:

```c
struct list_head
{
    struct list_head *next;
    struct list_head *prev;
};
```

---

# Creating a Linked List Node

User-defined structure:

```c
struct my_list
{
    struct list_head list;
    int data;
};
```

The `list_head` member links the node into the kernel linked list.

---

# Creating the List Head

Before creating nodes, create a list head.

## LIST_HEAD()

```c
LIST_HEAD(my_linked_list);
```

Example:

```c
LIST_HEAD(etx_linked_list);
```

Internally:

```c
struct list_head etx_linked_list =
{
    &etx_linked_list,
    &etx_linked_list
};
```

When:

```text
head->next == head
head->prev == head
```

The list is empty.

---

# Initializing a Node

For dynamically or statically allocated nodes:

```c
INIT_LIST_HEAD(&node.list);
```

Example:

```c
struct my_list node;

INIT_LIST_HEAD(&node.list);

node.data = 10;
```

This initializes:

```text
node.list.next = node.list
node.list.prev = node.list
```

---

# Adding Nodes

## Add After Head

Function:

```c
list_add(
    &node.list,
    &etx_linked_list
);
```

Effect:

```text
HEAD
 |
 v
NODE
 |
 v
OLD_FIRST_NODE
```

Used for:

```text
Stack (LIFO)
```

---

## Add Before Head

Function:

```c
list_add_tail(
    &node.list,
    &etx_linked_list
);
```

Effect:

```text
HEAD
 |
 v
...
 |
 v
NEW_NODE
 |
 v
HEAD
```

Used for:

```text
Queue (FIFO)
```

---

# Deleting Nodes

## list_del()

Removes node from list.

```c
list_del(&node.list);
```

Important:

```text
Removes linkage only
Memory is NOT freed
```

---

## list_del_init()

Deletes and reinitializes node.

```c
list_del_init(&node.list);
```

Node becomes standalone again.

---

# Replacing Nodes

## list_replace()

Replace old node with new node.

```c
list_replace(
    &old.list,
    &new.list
);
```

---

## list_replace_init()

Replace and reinitialize old node.

```c
list_replace_init(
    &old.list,
    &new.list
);
```

---

# Moving Nodes

## list_move()

Move node after head.

```c
list_move(
    &node.list,
    &etx_linked_list
);
```

---

## list_move_tail()

Move node before head.

```c
list_move_tail(
    &node.list,
    &etx_linked_list
);
```

---

# Rotating List

## list_rotate_left()

Rotate list left.

```c
list_rotate_left(
    &etx_linked_list
);
```

Example:

Before:

```text
HEAD -> A -> B -> C
```

After:

```text
HEAD -> B -> C -> A
```

---

# Testing List State

## list_empty()

Check whether list is empty.

```c
if(list_empty(&etx_linked_list))
{
    printk("Empty\n");
}
```

Returns:

```text
1 -> Empty
0 -> Not Empty
```

---

## list_is_last()

Check whether node is last.

```c
list_is_last(
    &node.list,
    &etx_linked_list
);
```

---

## list_is_singular()

Check whether list contains only one entry.

```c
list_is_singular(
    &etx_linked_list
);
```

---

# Splitting a List

## list_cut_position()

Split one list into two.

```c
list_cut_position(
    &new_list,
    &old_list,
    &entry->list
);
```

Example:

Before:

```text
HEAD
 |
 A -> B -> C -> D
```

After:

```text
LIST1:
A -> B

LIST2:
C -> D
```

---

# Joining Lists

## list_splice()

Join two linked lists.

```c
list_splice(
    &list2,
    &list1
);
```

Result:

```text
LIST1 + LIST2
```

Used commonly for:

* Stack implementation
* Queue implementation
* Batch insertion

---

# Traversing Linked Lists

## list_entry()

Convert list_head pointer to container structure.

```c
list_entry(
    ptr,
    struct my_list,
    list
);
```

Parameters:

| Parameter | Description       |
| --------- | ----------------- |
| ptr       | list_head pointer |
| type      | structure type    |
| member    | list_head member  |

---

# Forward Traversal

## list_for_each()

```c
struct list_head *pos;

list_for_each(
        pos,
        &etx_linked_list)
{
}
```

---

## list_for_each_entry()

Preferred method.

```c
struct my_list *node;

list_for_each_entry(
        node,
        &etx_linked_list,
        list)
{
    printk("%d\n",
           node->data);
}
```

---

# Safe Traversal

## list_for_each_entry_safe()

Safe while deleting nodes.

```c
struct my_list *node;
struct my_list *tmp;

list_for_each_entry_safe(
        node,
        tmp,
        &etx_linked_list,
        list)
{
    list_del(&node->list);
}
```

Used when removing nodes during traversal.

---

# Reverse Traversal

## list_for_each_prev()

```c
list_for_each_prev(
        pos,
        &etx_linked_list)
{
}
```

---

## list_for_each_entry_reverse()

```c
list_for_each_entry_reverse(
        node,
        &etx_linked_list,
        list)
{
    printk("%d\n",
           node->data);
}
```

---

# Typical Driver Use Cases

Linux kernel linked lists are heavily used in:

* Process management
* Device driver queues
* Workqueue management
* Timer management
* Networking subsystem
* USB subsystem
* Block layer
* Scheduler

Kernel developers frequently embed `struct list_head` inside driver-specific structures rather than storing data directly in the list node.

---

# Example Flow

```text
Create List Head
       |
       v
Create Node
       |
       v
INIT_LIST_HEAD()
       |
       v
list_add()
       |
       v
Traverse
       |
       v
list_del()
       |
       v
Free Memory
```

---

# Important APIs Summary

## Initialization

```c
LIST_HEAD()
INIT_LIST_HEAD()
```

## Add

```c
list_add()
list_add_tail()
```

## Delete

```c
list_del()
list_del_init()
```

## Replace

```c
list_replace()
list_replace_init()
```

## Move

```c
list_move()
list_move_tail()
```

## Test

```c
list_empty()
list_is_last()
list_is_singular()
```

## Split / Join

```c
list_cut_position()
list_splice()
```

## Traversal

```c
list_for_each()
list_for_each_entry()
list_for_each_entry_safe()
list_for_each_prev()
list_for_each_entry_reverse()
```

---
# Linux Device Driver - Linked List Example Program

## Overview

This example combines multiple Linux kernel concepts:

* Character Device Driver
* Interrupt Handling
* Workqueue
* Kernel Linked List
* Dynamic Memory Allocation (`kmalloc`)
* Safe List Traversal
* Safe Node Deletion

The driver demonstrates how to:

1. Receive data from userspace.
2. Trigger a software interrupt.
3. Schedule a Workqueue.
4. Create a linked list node inside the Workqueue.
5. Add the node to a kernel linked list.
6. Traverse and print the linked list.
7. Delete all nodes during module removal.

---

# High-Level Architecture

```text
echo 10 > /dev/etx_device
           |
           v
      Write Function
           |
           v
   Software Interrupt
           |
           v
        ISR
           |
           v
     queue_work()
           |
           v
      Workqueue
           |
           v
   Create Linked List Node
           |
           v
    Add Node To List
           |
           v
 cat /dev/etx_device
           |
           v
   Traverse Linked List
           |
           v
     Print All Nodes
```

---

# Core Data Structure

## Linked List Node

```c
struct my_list
{
    struct list_head list;
    int data;
};
```

### Purpose

| Member | Description                   |
| ------ | ----------------------------- |
| list   | Linux kernel linked list node |
| data   | User supplied value           |

Each node stores one integer value.

---

# Creating List Head

```c
LIST_HEAD(Head_Node);
```

Creates and initializes the list head.

Equivalent Concept:

```text
Head_Node
   |
   +--> Empty List
```

Initially:

```text
Head_Node.next = Head_Node
Head_Node.prev = Head_Node
```

---

# Workqueue Function

The actual linked list node is created inside the Workqueue.

```c
static void workqueue_fn(
        struct work_struct *work)
{
    struct my_list *temp_node;

    temp_node =
        kmalloc(
            sizeof(struct my_list),
            GFP_KERNEL);

    temp_node->data = etx_value;

    INIT_LIST_HEAD(
            &temp_node->list);

    list_add_tail(
            &temp_node->list,
            &Head_Node);
}
```

---

# What Happens Here?

## Step 1

Allocate memory.

```c
kmalloc()
```

Creates:

```text
+----------------+
| struct my_list |
+----------------+
```

---

## Step 2

Store received value.

```c
temp_node->data = etx_value;
```

Example:

```text
data = 10
```

---

## Step 3

Initialize embedded list.

```c
INIT_LIST_HEAD()
```

---

## Step 4

Insert into linked list.

```c
list_add_tail()
```

Example:

Before:

```text
HEAD
```

After Writing 10:

```text
HEAD <-> [10]
```

After Writing 20:

```text
HEAD <-> [10] <-> [20]
```

After Writing 30:

```text
HEAD <-> [10] <-> [20] <-> [30]
```

---

# Interrupt Handler

```c
static irqreturn_t irq_handler(
        int irq,
        void *dev_id)
{
    queue_work(
            own_workqueue,
            &work);

    return IRQ_HANDLED;
}
```

Purpose:

```text
Interrupt
    |
    v
Schedule Workqueue
```

The ISR does not create nodes directly.

It schedules deferred processing.

---

# Write Operation

```c
static ssize_t etx_write(...)
{
    sscanf(buf,"%d",&etx_value);

    asm("int $0x3B");

    return len;
}
```

---

# Write Flow

Example:

```bash
echo 10 > /dev/etx_device
```

Execution:

```text
User Writes 10
      |
      v
etx_write()
      |
      v
etx_value = 10
      |
      v
Software Interrupt
      |
      v
ISR
      |
      v
Workqueue
      |
      v
Create Node
      |
      v
Add Node
```

---

# Reading the Linked List

## Traversal

```c
list_for_each_entry(
        temp,
        &Head_Node,
        list)
{
    printk(
      "Node data=%d\n",
      temp->data);
}
```

---

# Example

Current List:

```text
HEAD
 |
 +--> 10
 |
 +--> 20
 |
 +--> 30
```

Output:

```text
Node 0 data = 10
Node 1 data = 20
Node 2 data = 30

Total Nodes = 3
```

---

# Traversal Macro

```c
list_for_each_entry(
        pos,
        head,
        member);
```

Parameters:

| Parameter | Description               |
| --------- | ------------------------- |
| pos       | Node pointer              |
| head      | List head                 |
| member    | Embedded list_head member |

Preferred Linux kernel traversal method.

---

# Example Session

## Add First Node

```bash
echo 10 > /dev/etx_device
```

List:

```text
HEAD
 |
 +--> 10
```

---

## Add Second Node

```bash
echo 20 > /dev/etx_device
```

List:

```text
HEAD
 |
 +--> 10
 |
 +--> 20
```

---

## Add Third Node

```bash
echo 30 > /dev/etx_device
```

List:

```text
HEAD
 |
 +--> 10
 |
 +--> 20
 |
 +--> 30
```

---

## Read Nodes

```bash
cat /dev/etx_device
```

Output:

```text
Node 0 data = 10
Node 1 data = 20
Node 2 data = 30

Total Nodes = 3
```

---

# Deleting All Nodes

During module removal:

```c
list_for_each_entry_safe(
        cursor,
        temp,
        &Head_Node,
        list)
{
    list_del(
            &cursor->list);

    kfree(cursor);
}
```

---

# Why Safe Traversal?

Unsafe:

```c
list_for_each_entry()
```

Problem:

```text
Delete Current Node
       |
       v
Next Pointer Invalid
```

May crash.

---

Safe:

```c
list_for_each_entry_safe()
```

Stores next node before deletion.

Suitable for:

```text
Delete While Traversing
```

---

# Module Removal Flow

```text
rmmod driver
      |
      v
Traverse List
      |
      v
list_del()
      |
      v
kfree()
      |
      v
Destroy Workqueue
      |
      v
free_irq()
      |
      v
Driver Removed
```

---

# Memory Management

## Allocation

```c
kmalloc(
        sizeof(struct my_list),
        GFP_KERNEL);
```

Creates:

```text
Kernel Heap
      |
      +--> Node
```

---

## Free

```c
kfree(node);
```

Releases memory.

Important:

```text
list_del()
does NOT free memory
```

Both operations are required.

---

# Why Linux Uses Embedded list_head?

Instead of:

```c
struct node
{
    int data;
    struct node *next;
};
```

Linux uses:

```c
struct my_list
{
    struct list_head list;
    int data;
};
```

Advantages:

* Generic implementation
* Reusable APIs
* Better cache locality
* Single memory allocation
* Used throughout kernel subsystems

This intrusive-list design is a common Linux kernel pattern.

---

# Important APIs Used

## Linked List

```c
LIST_HEAD()

INIT_LIST_HEAD()

list_add_tail()

list_for_each_entry()

list_for_each_entry_safe()

list_del()
```

---

## Memory

```c
kmalloc()

kfree()
```

---

## Workqueue

```c
create_workqueue()

queue_work()

destroy_workqueue()
```

---

## Interrupt

```c
request_irq()

free_irq()
```

---

# Driver Concept Demonstrated

This example is valuable because it combines multiple Linux driver concepts in one workflow:

```text
Userspace
    |
    v
Character Driver
    |
    v
Interrupt
    |
    v
ISR
    |
    v
Workqueue
    |
    v
Linked List
    |
    v
Kernel Memory Management
```

---

# Key Takeaways

* Linux kernel provides a built-in circular doubly linked list implementation.
* `struct list_head` is embedded inside user-defined structures.
* List heads are created using `LIST_HEAD()`.
* Nodes are initialized using `INIT_LIST_HEAD()`.
* `list_add()` inserts after head (stack behavior).
* `list_add_tail()` inserts before head (queue behavior).
* `list_del()` removes nodes but does not free memory.
* `list_for_each_entry()` is the preferred traversal method.
* `list_for_each_entry_safe()` should be used when deleting nodes during traversal.
* Linked lists are extensively used throughout Linux kernel subsystems and device drivers.

* `LIST_HEAD()` creates the linked list head.
* Each node embeds `struct list_head`.
* Nodes are dynamically allocated using `kmalloc()`.
* `list_add_tail()` appends nodes to the list.
* Interrupts trigger the Workqueue.
* Workqueue creates linked list nodes.
* `list_for_each_entry()` traverses the list.
* `list_for_each_entry_safe()` is used when deleting nodes.
* `list_del()` removes a node from the list but does not free memory.
* `kfree()` must be called to release allocated memory.
* This example demonstrates a complete producer-storage-traversal-cleanup workflow inside a Linux device driver.


# Conclusion
This is just a basic linux device driver which explains about the linked list in linux device driver.

Please refer this URL for the complete tutorial of this example source code.
https://embetronicx.com/tutorials/linux/device-drivers/example-linked-list-in-linux-kernel/
