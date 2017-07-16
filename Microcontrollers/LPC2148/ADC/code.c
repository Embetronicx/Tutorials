#include<lpc214x.h>
#include "LCD.h"
#include "ADC.h"

unsigned int val;

int main()
{
	IO1DIR=0xffffffff;
	IO0DIR=0x00000000;
	PINSEL0=0x0300;
	VPBDIV=0x02;
	lcd_init();
	show("ADC Value : ");
	while(1) {
		cmd(0x8b);
		val=adc(0,6);
		dat((val/1000)+48);
		dat(((val/100)%10)+48);
		dat(((val/10)%10)+48);
		dat((val%10)+48);
	}
}

