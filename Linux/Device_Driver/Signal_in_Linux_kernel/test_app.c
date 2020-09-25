/***************************************************************************//**
*  \file       test_app.c
*
*  \details    Userspace application to test the Device driver
*
*  \author     EmbeTronicX
*
* *******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <signal.h>
 
#define REG_CURRENT_TASK _IOW('a','a',int32_t*)
 
#define SIGETX 44
 
static int done = 0;
int check = 0;
 
void ctrl_c_handler(int n, siginfo_t *info, void *unused)
{
    if (n == SIGINT) {
        printf("\nrecieved ctrl-c\n");
        done = 1;
    }
}
 
void sig_event_handler(int n, siginfo_t *info, void *unused)
{
    if (n == SIGETX) {
        check = info->si_int;
        printf ("Received signal from kernel : Value =  %u\n", check);
    }
}
 
int main()
{
    int fd;
    int32_t value, number;
    struct sigaction act;
 
    printf("*********************************\n");
    printf("*******WWW.EmbeTronicX.com*******\n");
    printf("*********************************\n");
 
    /* install ctrl-c interrupt handler to cleanup at exit */
    sigemptyset (&act.sa_mask);
    act.sa_flags = (SA_SIGINFO | SA_RESETHAND);
    act.sa_sigaction = ctrl_c_handler;
    sigaction (SIGINT, &act, NULL);
 
    /* install custom signal handler */
    sigemptyset(&act.sa_mask);
    act.sa_flags = (SA_SIGINFO | SA_RESTART);
    act.sa_sigaction = sig_event_handler;
    sigaction(SIGETX, &act, NULL);
 
    printf("Installed signal handler for SIGETX = %d\n", SIGETX);
 
    printf("\nOpening Driver\n");
    fd = open("/dev/etx_device", O_RDWR);
    if(fd < 0) {
            printf("Cannot open device file...\n");
            return 0;
    }
 
    printf("Registering application ...");
    /* register this task with kernel for signal */
    if (ioctl(fd, REG_CURRENT_TASK,(int32_t*) &number)) {
        printf("Failed\n");
        close(fd);
        exit(1);
    }
    printf("Done!!!\n");
   
    while(!done) {
        printf("Waiting for signal...\n");
 
        //blocking check
        while (!done && !check);
        check = 0;
    }
 
    printf("Closing Driver\n");
    close(fd);
}