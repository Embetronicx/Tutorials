#include <lpc214x.h>


#define bit(x) (1<<x)

void lcd_init(void);
void cmd(unsigned char a);
void dat(unsigned char b);
void show(unsigned char *s);
void lcd_delay(void);

void ser_init(void);
void tx(unsigned char c);
unsigned char rx(void);
void tx_string(unsigned char *s);

int main()
{
	int i;
	unsigned char id[12];
	
	IO1DIR = 0xFFFFFFFF;
	ser_init();
	lcd_init();
	cmd(0x80);
	show("<<SHOW UR CARD>>");
	cmd(0xc0);
	for(i=0; i<12; i++) {
		id[i]=rx();
		dat(id[i]);
	} 	
	while(1);
}
void lcd_init()
{
	cmd(0x38);
	cmd(0x0e);
	cmd(0x01);
	cmd(0x06);
	cmd(0x0c);
	cmd(0x80);
}

void cmd(unsigned char a)
{
	IO1CLR=0xFF070000;
	IO1SET=(a<<24);
	IO1CLR=bit(16);				//rs=0
	IO1CLR=bit(17);				//rw=0
	IO1SET=bit(18);			  	//en=1
	lcd_delay();
	IO1CLR=bit(18);			   	//en=0
}

void dat(unsigned char b)
{
	IO1CLR=0xFF070000;
	IO1SET=(b<<24);
	IO1SET=bit(16);				//rs=1
	IO1CLR=bit(17);				//rw=0
	IO1SET=bit(18);			   	//en=1
	lcd_delay();
	IO1CLR=bit(18);			   	//en=0
}

void show(unsigned char *s)
{
	while(*s)
	{
		dat(*s++);
	}
}

void lcd_delay()
{
	unsigned int i;
	for(i=0;i<=3000;i++);
}
void ser_init()
{
	VPBDIV=0x02;							//PCLK = 30MHz
	PINSEL0|=0x05;
	U0LCR=0x83;
	U0DLL=195;
	U0DLM=0;
	U0LCR=0x03;
	U0TER=(1<<7);
}

void tx(unsigned char c)
{
	U0THR=c;
	while((U0LSR&(1<<5))==0);
}

void tx_string(unsigned char *s)
{
	while(*s) {
	tx(*s++);
	}
}

unsigned char rx()
{
	while((U0LSR&(1<<0))==0);
	return U0RBR;
}
