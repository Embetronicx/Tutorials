#include<lpc214x.h>

#define LED (1U<<31)

#define bit(x) (1<<x)

void lcd_init(void);
void cmd(unsigned char a);
void dat(unsigned char b);
void show(unsigned char *s);
void lcd_delay(void);

unsigned int val;
unsigned int adc(int,int);


int main()
{
    IO1DIR=0xffffffff;
    IO0DIR=0x80000000;
    PINSEL0=0x0300;
    VPBDIV=0x02;
    lcd_init();
    while(1) {
        cmd(0x80);
        adc(0,6);
        show("LIGHT INT : ");
        if(val>800) {
            show("LOW ");
            IO0SET = LED;
        } else {
            show("HIGH");
            IO0CLR = LED;
        }
    }
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
    IO1CLR=bit(16);             //rs=0
    IO1CLR=bit(17);             //rw=0
    IO1SET=bit(18);             //en=1
    lcd_delay();
    IO1CLR=bit(18);             //en=0
}

void dat(unsigned char b)
{
    IO1CLR=0xFF070000;
    IO1SET=(b<<24);
    IO1SET=bit(16);             //rs=1
    IO1CLR=bit(17);             //rw=0
    IO1SET=bit(18);             //en=1
    lcd_delay();
    IO1CLR=bit(18);             //en=0
}

void show(unsigned char *s)
{
    while(*s) {
        dat(*s++);
    }
}

void lcd_delay()
{
    unsigned int i;
    for(i=0;i<=3000;i++);
}

unsigned int adc(int no,int ch)
{
    switch(no)                                    //select adc
    {
        case 0: AD0CR=0x00200600|(1<<ch);       //select channel
                AD0CR|=(1<<24);                 //start conversion
                while((AD0GDR& (1U<<31))==0);
                val=AD0GDR;
                break;

        case 1: AD1CR=0x00200600|(1<<ch);       //select channel
                AD1CR|=(1<<24);                 //start conversion
                while((AD1GDR&(1U<<31))==0);
                val=AD1GDR;
                break;
    }
    val=(val >> 6) & 0x03FF;                   // bit 6:15 is 10 bit AD value

    return val;
}