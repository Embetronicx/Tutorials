#include <stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "uart0.h"
#include "semphr.h"

void task1(void *q);
void task2(void *a);
void initpll(void);

xSemaphoreHandle binarysem;

int main(void)
{
	initpll();
	initserial();
	vSemaphoreCreateBinary(binarysem);
	xTaskCreate(task1,"task1",128,NULL,1,NULL);
	xTaskCreate(task2,"task2",128,NULL,1,NULL);
	vTaskStartScheduler();
	while(1);
}
void task1(void *q)
{	
	while(1) {	
		xSemaphoreTake(binarysem,portMAX_DELAY);
		sendsserial("Task1 functioning");
		sendsserial("\r\n");
		xSemaphoreGive(binarysem);
		vTaskDelay(1);
	}
}

void task2(void *a)
{
	while(1) {
		xSemaphoreTake(binarysem,portMAX_DELAY);
		sendsserial("Task2 functioning");
		sendsserial("\r\n");
		xSemaphoreGive(binarysem);
		vTaskDelay(1);
	}
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
