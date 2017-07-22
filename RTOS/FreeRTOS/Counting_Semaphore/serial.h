void ser_init(void);
void tx(unsigned char c);
unsigned char rx(void);
void tx_string(unsigned char *s);
void rx1(void)__irq;

void initserial()
{
VPBDIV=0x01;
PINSEL0=0x5;
U0LCR=0x83;
U0DLL=136;   //u0dll=30Mhz/(16*9600)
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
while(*sdat)
{
sendserial(*sdat++);
}
}
/*
unsigned char rx()
{
while((U0LSR&(1<<0))==0);
return U0RBR;
}*/


