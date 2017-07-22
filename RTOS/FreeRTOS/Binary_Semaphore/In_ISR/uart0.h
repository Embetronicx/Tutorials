
void initserial(void);
void sendserial(unsigned char c);
void rx1(void)__irq;
void sendsserial(unsigned char *s);

void initserial()
{
VPBDIV=0x02;
PINSEL0|=0x5;
U0LCR=0x83;
U0DLL=195;   //u0dll=30Mhz/(16*9600)
U0DLM=0;
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
while(*sdat)
{
sendserial(*sdat++);
}
}

void rx1(void)__irq
{
	
	//unsigned char r;
	
  if(U0IIR&0x04)
	{
		xSemaphoreGiveFromISR(binarysemaphore,&xHigherPriorityTaskWoken);
	//	r=U0RBR;
	//	U0THR=r;
	//	while(!(U0LSR&0x20));
	}
	VICVectAddr = 0x00;
	
}
