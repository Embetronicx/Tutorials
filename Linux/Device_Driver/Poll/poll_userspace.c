/***************************************************************************//**
*  \file       poll_userspace.c
*
*  \details    poll user space application
*
*  \author     EmbeTronicX
*
*  \Tested with Linux raspberrypi 5.4.51-v7l+
*
* *******************************************************************************/

#include <assert.h>
#include <fcntl.h>
#include <poll.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main()
{
  char kernel_val[20];
  int fd, ret;
  struct pollfd pfd;
  
  fd = open("/dev/etx_device", O_RDWR | O_NONBLOCK);
    
  if( fd == -1 )  
  {
    perror("open");
    exit(EXIT_FAILURE);
  }
    
  pfd.fd = fd;
  pfd.events = ( POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM );
    
  while( 1 ) 
  {
    puts("Starting poll...");
    
    ret = poll(&pfd, (unsigned long)1, 5000);   //wait for 5secs
    
    if( ret < 0 ) 
    {
      perror("poll");
      assert(0);
    }
    
    
    if( ( pfd.revents & POLLIN )  == POLLIN )
    {
      read(pfd.fd, &kernel_val, sizeof(kernel_val));
      printf("POLLIN : Kernel_val = %s\n", kernel_val);
    }
    
    if( ( pfd.revents & POLLOUT )  == POLLOUT )
    {
      strcpy( kernel_val, "User Space");
      write(pfd.fd, &kernel_val, strlen(kernel_val));
      printf("POLLOUT : Kernel_val = %s\n", kernel_val);
    }
  }
  
  if(close(fd))
  {
    perror("Failed to close file descriptor\n");
    return 1;
  }
  
  return 0;
}
