/***************************************************************************//**
*  \file       driver.c
*
*  \details    Simple Linux device driver (Seqlock)
*
*  \author     EmbeTronicX
*
* *******************************************************************************/
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kdev_t.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include<linux/slab.h>                 //kmalloc()
#include<linux/uaccess.h>              //copy_to/from_user()
#include <linux/kthread.h>             //kernel threads
#include <linux/sched.h>               //task_struct 
#include <linux/delay.h>
#include <linux/seqlock.h>
 
//Seqlock variable
seqlock_t etx_seq_lock;
 
unsigned long etx_global_variable = 0;
dev_t dev = 0;
static struct class *dev_class;
static struct cdev etx_cdev;
 
static int __init etx_driver_init(void);
static void __exit etx_driver_exit(void);
 
static struct task_struct *etx_thread1;
static struct task_struct *etx_thread2; 
 
/*************** Driver Fuctions **********************/
static int etx_open(struct inode *inode, struct file *file);
static int etx_release(struct inode *inode, struct file *file);
static ssize_t etx_read(struct file *filp, 
                char __user *buf, size_t len,loff_t * off);
static ssize_t etx_write(struct file *filp, 
                const char *buf, size_t len, loff_t * off);
 /******************************************************/
 
int thread_function1(void *pv);
int thread_function2(void *pv);
 
//Thread used for writing
int thread_function1(void *pv)
{
    while(!kthread_should_stop()) {  
        write_seqlock(&etx_seq_lock);
        etx_global_variable++;
        write_sequnlock(&etx_seq_lock);
        msleep(1000);
    }
    return 0;
}
 
//Thread used for reading
int thread_function2(void *pv)
{
    unsigned int seq_no;
    unsigned long read_value;
    while(!kthread_should_stop()) {
        do {
            seq_no = read_seqbegin(&etx_seq_lock);
        read_value = etx_global_variable;
    } while (read_seqretry(&etx_seq_lock, seq_no));
        printk(KERN_INFO "In EmbeTronicX Thread Function2 : Read value %lu\n", read_value);
        msleep(1000);
    }
    return 0;
}
 
static struct file_operations fops =
{
        .owner          = THIS_MODULE,
        .read           = etx_read,
        .write          = etx_write,
        .open           = etx_open,
        .release        = etx_release,
};
 
static int etx_open(struct inode *inode, struct file *file)
{
        printk(KERN_INFO "Device File Opened...!!!\n");
        return 0;
}
 
static int etx_release(struct inode *inode, struct file *file)
{
        printk(KERN_INFO "Device File Closed...!!!\n");
        return 0;
}
 
static ssize_t etx_read(struct file *filp, 
                char __user *buf, size_t len, loff_t *off)
{
        printk(KERN_INFO "Read function\n");
 
        return 0;
}

static ssize_t etx_write(struct file *filp, 
                const char __user *buf, size_t len, loff_t *off)
{
        printk(KERN_INFO "Write Function\n");
        return len;
}
 
static int __init etx_driver_init(void)
{
        /*Allocating Major number*/
        if((alloc_chrdev_region(&dev, 0, 1, "etx_Dev")) <0){
                printk(KERN_INFO "Cannot allocate major number\n");
                return -1;
        }
        printk(KERN_INFO "Major = %d Minor = %d \n",MAJOR(dev), MINOR(dev));
 
        /*Creating cdev structure*/
        cdev_init(&etx_cdev,&fops);
 
        /*Adding character device to the system*/
        if((cdev_add(&etx_cdev,dev,1)) < 0){
            printk(KERN_INFO "Cannot add the device to the system\n");
            goto r_class;
        }
 
        /*Creating struct class*/
        if((dev_class = class_create(THIS_MODULE,"etx_class")) == NULL){
            printk(KERN_INFO "Cannot create the struct class\n");
            goto r_class;
        }
 
        /*Creating device*/
        if((device_create(dev_class,NULL,dev,NULL,"etx_device")) == NULL){
            printk(KERN_INFO "Cannot create the Device \n");
            goto r_device;
        }
 
        
        /* Creating Thread 1 */
        etx_thread1 = kthread_run(thread_function1,NULL,"eTx Thread1");
        if(etx_thread1) {
            printk(KERN_ERR "Kthread1 Created Successfully...\n");
        } else {
            printk(KERN_ERR "Cannot create kthread1\n");
             goto r_device;
        }
 
         /* Creating Thread 2 */
        etx_thread2 = kthread_run(thread_function2,NULL,"eTx Thread2");
        if(etx_thread2) {
            printk(KERN_ERR "Kthread2 Created Successfully...\n");
        } else {
            printk(KERN_ERR "Cannot create kthread2\n");
             goto r_device;
        }
 
        //Initialize the seqlock
        seqlock_init(&etx_seq_lock);
        
        printk(KERN_INFO "Device Driver Insert...Done!!!\n");
        return 0;
 
 
r_device:
        class_destroy(dev_class);
r_class:
        unregister_chrdev_region(dev,1);
        cdev_del(&etx_cdev);
        return -1;
}
 
static void __exit etx_driver_exit(void)
{
        kthread_stop(etx_thread1);
        kthread_stop(etx_thread2);
        device_destroy(dev_class,dev);
        class_destroy(dev_class);
        cdev_del(&etx_cdev);
        unregister_chrdev_region(dev, 1);
        printk(KERN_INFO "Device Driver Remove...Done!!\n");
}
 
module_init(etx_driver_init);
module_exit(etx_driver_exit);
 
MODULE_LICENSE("GPL");
MODULE_AUTHOR("EmbeTronicX <embetronicx@gmail.com>");
MODULE_DESCRIPTION("A simple device driver - Seqlock");
MODULE_VERSION("1.28");