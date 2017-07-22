#include<stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"

void initserial(void);
void sendserial(unsigned char c);
void rx1(void)__irq;
void sendsserial(unsigned char *s);

void initpll(void);
void recsemaphore(void *q);

xSemaphoreHandle binarysemaphore;

int main()
{
	vSemaphoreCreateBinary(binarysemaphore);
	initserial();
	xSemaphoreTake(binarysemaphore,portMAX_DELAY);
	xTaskCreate(recsemaphore,"intertask",128,NULL,1,NULL);
	vTaskStartScheduler();
	while(1);
}

void initpll(void)
{
	PLL0CON=0x01;
	PLL0CFG=0x24;
	PLL0FEED=0xAA;
	PLL0FEED=0x55;
	while(!(PLL0STAT&1<<10));
	PLL0CON=0x03;
	PLL0FEED=0xAA;
	PLL0FEED=0x55;
	VPBDIV=0x01;
}

void recsemaphore(void *q)
{
	while(1) {
		if(xSemaphoreTake(binarysemaphore,portMAX_DELAY)==pdTRUE) {
			sendsserial("Received Semaphore From ISR");
			sendsserial("\r\n");
			sendsserial("\r\n");
		}
  }
}

void initserial()
{
	VPBDIV=0x01;
	PINSEL0|=0x5;
	U0LCR=0x83;
	U0DLL=136;   //u0dll=60Mhz/(16*9600)
	U0DLM=1;
	U0LCR=0x03;
	U0TER=(1<<7);
	U0IER=0x01;  //enables uart receive identification interrupt
	VICIntSelect=0x0000;     //selecting as irq
	VICIntEnable|=0x0040;   //enable uart1
	VICVectAddr2=(unsigned long int)rx1;  //assigning address
	VICVectCntl2=0x26;  //need to assign slot no of interrupt source which has been activated
}


void sendserial(unsigned char dat)
{
	U0THR=dat;
	while((U0LSR&(1<<5))==0);
}

void sendsserial(unsigned char *sdat)
{
	while(*sdat) {
		sendserial(*sdat++);
	}
}

void rx1(void)__irq
{
	unsigned char r;
	static portBASE_TYPE interrupttask;
	interrupttask=pdFALSE;
	
  if(U0IIR&0x04) {
		r=U0RBR;
		sendsserial("Received Data : ");
		U0THR=r;
		while(!(U0LSR&0x20));
		sendsserial("\r\n");
		sendsserial("Going to give semaphore");
		sendsserial("\r\n");
		xSemaphoreGiveFromISR(binarysemaphore,&interrupttask);
		sendsserial("Semaphore has given");
		sendsserial("\r\n");
	}
	VICVectAddr = 0x00;
}


	
	