void initserial(void);
void sendserial(unsigned char c);
unsigned char rx(void);
void sendsserial(unsigned char *sdat);

void initserial()
{
	VPBDIV=0x02;
	PINSEL0|=0x5;
	U0LCR=0x83;
	U0DLL=195;   //u0dll=30Mhz/(16*9600)
	U0DLM=0;
	U0LCR=0x03;
	U0TER=(1<<7);
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

unsigned char rx()
{
	while((U0LSR&(1<<0))==0);
	return U0RBR;
}
