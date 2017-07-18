#include<lpc214x.h>
#include"TIMER.H"
#include"ULTRASONIC.H"
#include"LCD.H"

#define delay for(i=0;i<65000;i++);

unsigned int range=0,i;

int main()
{
	VPBDIV=0x01;				 // PCLK = 60MHz
	IO1DIR=0xffffffff;
	ultrasonic_init();
	lcd_init();
	show("Distance : ");

	while(1) {
		cmd(0x8b);
		range=get_range();
		dat((range/100)+48);
		dat(((range/10)%10)+48);
		dat((range%10)+48);
		show("cm");
		delay;
		delay;
	}
}
