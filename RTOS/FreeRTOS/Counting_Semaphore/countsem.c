#include <stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "serial.h"
#include "semphr.h"

void initpll(void);
void task1(void *p);
void task2(void *p);

xSemaphoreHandle countingsemaphore;

int main()
{
	initserial();
	countingsemaphore=xSemaphoreCreateCounting(3,0);
	xTaskCreate(task1,"task1",128,NULL,1,NULL);
	xTaskCreate(task2,"task2",128,NULL,1,NULL);
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
void task1(void *p)
{
	while(1) {
		if(countingsemaphore!=NULL) {			
			if(xSemaphoreTake(countingsemaphore,portMAX_DELAY)==pdTRUE) {
				sendsserial("Task 1 Takes Semaphore");
				sendsserial("\r\n");
				sendsserial("\r\n");
			}
		}
	}
}
void task2(void *p)
{
	while(1) {
		if(countingsemaphore!=NULL) {			
			if(xSemaphoreTake(countingsemaphore,portMAX_DELAY )==pdTRUE) {
				sendsserial("Task 2 Takes Semaphore");
				sendsserial("\r\n");
				sendsserial("\r\n");
			}
		}
	}
}
void rx1(void)__irq
{
	static portBASE_TYPE interrupttask;
	unsigned char r;
	
  if(U0IIR&0x04) {
		r=U0RBR;
		sendsserial("Received Data = ");
		U0THR=r;
		while(!(U0LSR&0x20));
		sendsserial("\r\n");
		sendsserial("Going to Give Semaphore From ISR");
		sendsserial("\r\n");
		xSemaphoreGiveFromISR(countingsemaphore,&interrupttask );		
	}
	VICVectAddr = 0x00;
	
}
