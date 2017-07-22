#include<stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "uart0.h"

void print_task(void *q);
void initpll(void);

int main(void)
{
	initpll();
	initserial();
	xTaskCreate(print_task,"task1",128,"Task1 functioning",1,NULL);
	xTaskCreate(print_task,"task2",128,"Task2 functioning",2,NULL);
	vTaskStartScheduler();
}
void print_task(void *q)
{
	unsigned char *p;
	while(1) {
		p=(unsigned char *)q;
		sendsserial(p);
		sendsserial("\r\n");
		vTaskDelay(1000);
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
