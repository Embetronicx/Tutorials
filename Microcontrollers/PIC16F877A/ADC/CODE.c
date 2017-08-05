#include<pic.h>
#define delay for(i=0;i<=1000;i++)
#define rs RC0
#define rw RC1
#define e RC2

__CONFIG( FOSC_HS & WDTE_OFF & PWRTE_OFF & CP_OFF & BOREN_ON & LVP_OFF & CPD_OFF & WRT_OFF & DEBUG_OFF);

void adc();

void lcd_int();
void cmd(unsigned char a);
void dat(unsigned char b);
void show(unsigned char *s);

int i;

void main()
{
	TRISB=TRISC=0;			//Port B and Port C is Output (LCD)
	TRISA0=1;				//RA0 is input (ADC)
	lcd_int();
	show("ADC Value :");
	while(1) {
		cmd(0x8C);
		adc();
	}
}

void lcd_int()
{
	cmd(0x38);
	cmd(0x0c);
	cmd(0x06);
	cmd(0x80);
}

void cmd(unsigned char a)
{
	PORTB=a;
	rs=0;
	rw=0;
	e=1;
	delay;
	e=0;
}

void dat(unsigned char b)
{
	PORTB=b;
	rs=1;
	rw=0;
	e=1;
	delay;
	e=0;
}		

void show(unsigned char *s)
{
	while(*s) {
		dat(*s++);
	}
}

void adc()
{
	unsigned int adcval;
	
	ADCON1=0xc0;					//right justified
	ADCON0=0x85;					//adc on, fosc/64
	while(GO_nDONE);				//wait until conversion is finished
	adcval=((ADRESH<<8)|(ADRESL));	//store the result
	adcval=(adcval/3)-1;
	dat((adcval/1000)+48);
	dat(((adcval/100)%10)+48);
	dat(((adcval/10)%10)+48);
	dat((adcval%10)+48);	
}						