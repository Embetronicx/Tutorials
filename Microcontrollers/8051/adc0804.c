/****************************************************************************************
* This is the source code for ADC0804 interfacing with 8051
* You can find the explanation in this link : http://www.embetronicx.com/8051/adc0804/
*****************************************************************************************/

#include<reg51.h>

#define delay for(i=0;i<1000;i++);
#define lcd P2

sbit rd=P0^0;
sbit wr=P0^1;
sbit intr=P0^2;

sbit rs=P0^5;
sbit rw=P0^6;
sbit en=P0^7;

void lcd_int();
void cmd(unsigned int b);
void dat(unsigned int c);
void show(unsigned char *s);

unsigned char adc(),get_value, conv;
int i;

void main()
{
	lcd_int();
	show("Temp : ");
	while(1)
		{
		get_value = adc();
		cmd(0x87);
		dat((get_value/100)+48);
		dat(((get_value/10)%10)+48);
		dat((get_value%10)+48);
		dat(0x60);
		dat('C');
		}
}

void lcd_int()
{
	cmd(0x38);
	cmd(0x0e);
	cmd(0x06);
	cmd(0x01);
	cmd(0x80);
}

void cmd(unsigned int b)
{
	lcd=b;
	rs=0;
	rw=0;
	en=1;
	delay;
	en=0;
}

void dat(unsigned int c)
{
	lcd=c;
	rs=1;
	rw=0;
	en=1;
	delay;
	en=0;
}

void show(unsigned char *s)
{
	while(*s)
		dat(*s++);
}

unsigned char adc()
{
	wr=0;
	rd=1;
	wr=1;
	while(intr==1);
	rd=0;
	conv=P1;
	
	return conv;
}


