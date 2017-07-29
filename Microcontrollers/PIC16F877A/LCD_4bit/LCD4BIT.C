#include <pic.h>

__CONFIG( FOSC_HS & WDTE_OFF & PWRTE_OFF & CP_OFF & BOREN_ON & LVP_OFF & CPD_OFF & WRT_OFF & DEBUG_OFF);


#define rs RD2
#define en RD3

void lcd_init();
void cmd(unsigned char a);
void dat(unsigned char b);
void show(unsigned char *s);
void lcd_delay();

void main()
{
	unsigned int i;
	TRISB=TRISD2=TRISD3=0;
	lcd_init();
	cmd(0x90);
	show("www.EmbeTronicX.com");
	while(1)
	{
		for(i=0;i<15000;i++);
		cmd(0x18);
		for(i=0;i<15000;i++);
		
	}	
}

void lcd_init()
{
	cmd(0x02);
	cmd(0x28);
	cmd(0x0e);
	cmd(0x06);
	cmd(0x80);
}

void cmd(unsigned char a)
{
	rs=0; 
	PORTB&=0x0F;
	PORTB|=(a&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
	PORTB&=0x0f;
	PORTB|=(a<<4&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
}

void dat(unsigned char b)
{
	rs=1; 
	PORTB&=0x0F;
	PORTB|=(b&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
	PORTB&=0x0f;
	PORTB|=(b<<4&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
}

void show(unsigned char *s)
{
	while(*s) {
		dat(*s++);
	}
}

void lcd_delay()
{
	unsigned int lcd_delay;
	for(lcd_delay=0;lcd_delay<=1000;lcd_delay++);
}

