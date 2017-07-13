#include<reg51.h>

#define adc_data P0
#define lcd			P1

unsigned char temp, gas;

sbit rs=P1^0;
sbit en=P1^1;

sbit OE		=P2^0;
sbit EOC	=P2^1;
sbit START	=P2^2;
sbit AA		=P2^4;
sbit BB		=P2^5;
sbit CC		=P2^6;
sbit ALE	=P2^7;

unsigned char adc_val;

void lcd_init();
void cmd(unsigned char a);
void dat(unsigned char b);
void show(unsigned char *s);
void lcd_delay();

unsigned char adc(unsigned int ch);
void ch_sel(unsigned int sel);

void  main()
{
	lcd_init();
	show("TEMP: ");
	cmd(0xc0);
	show("GAS : ");
	while(1) {
		cmd(0x86);
		temp=adc(0);										//Reading Value from ADC Channel 0
		dat((temp/100)%10 +0x30);
		dat((temp/10)%10 +0x30);
		dat(temp%10 +0x30);
		
		cmd(0xc6);
		gas=adc(1);											//Reading Value from ADC Channel 1
		dat((gas/100)%10 +0x30);
		dat((gas/10)%10 +0x30);
		dat(gas%10 +0x30);
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
	lcd&=0x0F;
	P1|=(a&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
	lcd&=0x0f;
	lcd|=(a<<4&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
}

void dat(unsigned char b)
{
	rs=1; 
	lcd&=0x0F;
	lcd|=(b&0xf0);
	en=1;
	lcd_delay();
	en=0;
	lcd_delay();
	lcd&=0x0f;
	lcd|=(b<<4&0xf0);
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

unsigned char adc(unsigned int ch)
{
	adc_data=0xff;

	ALE=START=OE=AA=BB=CC=0;
	EOC=1;

	ch_sel(ch);

	ALE=1;
	START=1;
	ALE=0;
	START=0;
	while(EOC==1);
	while(EOC==0);
	OE=1;
	adc_val=adc_data;
	OE=0;
	return adc_val;
}

void ch_sel(unsigned int sel)
{
	switch(sel) {
		case 0: CC=0;BB=0;AA=0; break;			//000
		case 1: CC=0;BB=0;AA=1; break;			//001
		case 2: CC=0;BB=1;AA=0; break;			//010
		case 3: CC=0;BB=1;AA=1; break;			//011
		case 4: CC=1;BB=0;AA=0; break;			//100
		case 5: CC=1;BB=0;AA=1; break;			//101
		case 6: CC=1;BB=1;AA=0; break;			//110
		case 7: CC=1;BB=1;AA=1; break;			//111
	}
}



