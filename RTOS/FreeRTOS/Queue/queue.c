#include<stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "uart0.h"
#include "queue.h"
#include "semphr.h"
void task1(void *u);
void task2(void *a);
void readqueue(void *p);
QueueHandle_t myqueue;
int main()
{
	myqueue=xQueueCreate(10,sizeof(char));
	if(myqueue!=NULL)
	{
		xTaskCreate(task1,"task1",128,NULL,1,NULL);
		xTaskCreate(task2,"task2",128,NULL,1,NULL);
		xTaskCreate(readqueue,"read",128,NULL,1,NULL);
		vTaskStartScheduler();
	}
/*	void vATask( void *pvParameters )
 {
 QueueHandle_t xQueue1, xQueue2;

	// Create a queue capable of containing 10 uint32_t values.
	xQueue1 = xQueueCreate( 10, sizeof( uint32_t ) );
	if( xQueue1 == 0 )
	{
		// Queue was not created and must not be used.
	}

	// Create a queue capable of containing 10 pointers to AMessage structures.
	// These should be passed by pointer as they contain a lot of data.
	xQueue2 = xQueueCreate( 10, sizeof( struct AMessage * ) );
	if( xQueue2 == 0 )
	{
		// Queue was not created and must not be used.
	}

	// ... Rest of task code.
 }*/
}

void task1(void *u)
{
	portBASE_TYPE qstatus;
	while(1)
	{
	qstatus=xQueueSendToBack(myqueue,"Rajesh",0);
	if(qstatus!=pdPASS)
		sendsserial("Queue is full");
  }
}
void task2(void *u)
{
	portBASE_TYPE qstatus;
	while(1)
	{
	qstatus=xQueueSendToBack(myqueue,"Kumar",0);
	if(qstatus!=pdPASS)
		sendsserial("Queue is full");
  }
}
void readqueue(void *p)
{
	unsigned char receivedValue;
	portBASE_TYPE xStatus;
	
	while(1)
	{
		xStatus = xQueueReceive(myqueue,&receivedValue,100);
    if( xStatus == pdPASS )
     {
			// sendserial('a');
			 
		 }
		
	}
}
