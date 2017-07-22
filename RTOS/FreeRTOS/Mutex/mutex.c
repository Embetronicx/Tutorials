#include <stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "uart0.h"
#include "semphr.h"

void initpll(void);
void task1(void *p);
void task2(void *p);

xSemaphoreHandle xMutex=NULL;

int main()
{	
  initpll();
	initserial();  

	xMutex=xSemaphoreCreateMutex();
//xMutex will be storing NULL when Mutex not created
	if(xMutex!=NULL) {
		xTaskCreate(task1,"task1",128,NULL,1,NULL);
		xTaskCreate(task2,"task2",128,NULL,1,NULL);
		vTaskStartScheduler();
	}
  while(1);

}

void task1(void *p)
{
	while(1) {
		xSemaphoreTake(xMutex,portMAX_DELAY );
		sendsserial("Task1 functioning");
		sendsserial("\r\n");
		xSemaphoreGive( xMutex );
		vTaskDelay(5);
  }
}

void task2(void *p)
{
	while(1)
	{
		xSemaphoreTake(xMutex,portMAX_DELAY );
		sendsserial("Task2 functioning");
		sendsserial("\r\n");
		xSemaphoreGive(xMutex);
		vTaskDelay(5);
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



