/***************************************************************************//**
*  \file       select_userspace.c
*
*  \details    select user space application
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
  char   kernel_val[20];
  fd_set read_fd, write_fd;
  struct timeval timeout;
  int    ret;
  int    fd = open("/dev/etx_device", O_RDWR | O_NONBLOCK);
  
  if( fd == -1 )  
  {
    perror("open");
    exit(EXIT_FAILURE);
  }
  
  while( 1 ) 
  {
    puts("Starting Select...");
    
    /* Initialize the file descriptor set. */
    FD_ZERO( &read_fd );
    FD_SET( fd, &read_fd );
    FD_ZERO( &write_fd );
    FD_SET( fd, &write_fd );
    
    /* Initialize the timeout */
    timeout.tv_sec  = 5;       //5 Seconds
    timeout.tv_usec = 0;
    
    ret = select(FD_SETSIZE, &read_fd, &write_fd, NULL, &timeout);
    
    if( ret < 0 ) 
    {
      perror("select");
      assert(0);
    }
    
    if( FD_ISSET( fd, &read_fd ) )
    {
      read(fd, &kernel_val, sizeof(kernel_val));
      printf("READ : Kernel_val = %s\n", kernel_val);
    }
    
    if( FD_ISSET( fd, &write_fd ) )
    {
      strcpy( kernel_val, "User Space");
      write(fd, &kernel_val, strlen(kernel_val));
      printf("WRITE : Kernel_val = %s\n", kernel_val);
    }
  }
  
  return 0;
}
