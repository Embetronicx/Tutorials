/***************************************************************************//**
*  \file       epoll_userspace.c
*
*  \details    epoll user space application
*
*  \author     EmbeTronicX
*
*  \Tested with Linux raspberrypi 5.4.51-v7l+
*
* *******************************************************************************/

#include <assert.h>
#include <fcntl.h>
#include <sys/epoll.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define EPOLL_SIZE ( 256 )
#define MAX_EVENTS (  20 )

int main()
{
  char kernel_val[20];
  int fd, epoll_fd, ret, n;
  struct epoll_event ev,events[20];
  
  fd = open("/dev/etx_device", O_RDWR | O_NONBLOCK);
    
  if( fd == -1 )  
  {
    perror("open");
    exit(EXIT_FAILURE);
  }
  
  //Create epoll instance
  epoll_fd = epoll_create(EPOLL_SIZE);
  
  if( epoll_fd < 0 )  
  {
    perror("epoll_create");
    exit(EXIT_FAILURE);
  }
    
  ev.data.fd = fd;
  ev.events  = ( EPOLLIN | EPOLLOUT );
  
  //Add the fd to the epoll
  if( epoll_ctl( epoll_fd, EPOLL_CTL_ADD, fd, &ev ) )
  {
    perror("Failed to add file descriptor to epoll\n");
    close(epoll_fd);
    exit(EXIT_FAILURE);
  }
    
  while( 1 ) 
  {
    puts("Starting Epoll...");
    
    ret = epoll_wait( epoll_fd, events, MAX_EVENTS, 5000);;   //wait for 5secs
    
    if( ret < 0 ) 
    {
      perror("epoll_wait");
      close(epoll_fd);
      assert(0);
    }
    
    for( n=0; n<ret; n++ )
    {    
      if( ( events[n].events & EPOLLIN )  == EPOLLIN )
      {
        read(events[n].data.fd, &kernel_val, sizeof(kernel_val));
        printf("EPOLLIN : Kernel_val = %s\n", kernel_val);
      }
      
      if( ( events[n].events & EPOLLOUT )  == EPOLLOUT )
      {
        strcpy( kernel_val, "User Space");
        write(events[n].data.fd, &kernel_val, strlen(kernel_val));
        printf("EPOLLOUT : Kernel_val = %s\n", kernel_val);
      }
    }
  }
  
  if(close(epoll_fd))
  {
    perror("Failed to close epoll file descriptor\n");
    return 1;
  }
  
  if(close(fd))
  {
    perror("Failed to close file descriptor\n");
    return 1;
  }
  
  return 0;
}
