#include<stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "uart0.h"
#include "queue.h"
#include "semphr.h"

void sender(void *u);
void readqueue(void *p);

xQueueHandle myqueue;

int main()
{
	initserial();
	
	myqueue=xQueueCreate(11,sizeof(char));
	
	if(myqueue!=NULL) {
		xTaskCreate(sender,"sender",128,NULL,1,NULL);
		xTaskCreate(readqueue,"read",128,NULL,1,NULL);
		vTaskStartScheduler();
	}
}

void sender(void *u)
{
	portBASE_TYPE qstatus;
	unsigned char dat[]="EmbeTronicX",i;
	while(1) {
			for(i=0;i<11;i++)   
				qstatus=xQueueSendToBack(myqueue,&dat[i],0);
		
			if(qstatus!=pdPASS) {
				sendsserial("\r\n");
				vTaskDelay(10);
			}
  }
}

void readqueue(void *p)
{
	unsigned char receivedValue;
	portBASE_TYPE xStatus;
	
	while(1) {
		xStatus = xQueueReceive(myqueue,&receivedValue,100);
    if( xStatus == pdPASS ) {
			 sendserial(receivedValue);
		 }
	}
}
