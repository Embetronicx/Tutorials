#include<pic.h>

#define LED PORTD

void interrupt  ISR(void)
{
	unsigned int i,j;
	LED=0X55;
	for(i=0;i<600;i++)
	for(j=0;j<200;j++);
	INTF=0;
}


void main(void)
{
	LED=0;
	TRISB0=1;
	TRISD=0;
	OPTION_REG=0X00;		//falling edge int @ enable pullup portb
	INTCON|=0Xd0;
	while(1) {
		LED=0x00;
	}
}