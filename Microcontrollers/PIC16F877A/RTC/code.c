#include<pic.h>
#include"lcd.h"

__CONFIG( FOSC_HS & WDTE_OFF & PWRTE_OFF & CP_OFF & BOREN_ON & LVP_OFF & CPD_OFF & WRT_OFF & DEBUG_OFF);

unsigned char sec,min,hour,day,date,month,year;


void rtc_int();
void rtc_start();
void rtc_stop();
void rtc_ack();
void rtc_nak();
void rtc_res();
void rtc_send(unsigned char a);
void rtc_send_byte(unsigned char addr,unsigned char data);
unsigned char rtc_read();
unsigned char rtc_read_byte(unsigned char addr);
void waitmssp();
unsigned char convup(unsigned char bcd);
unsigned char convd(unsigned char bcd);


void main()
{
	lcd_init();
	
	show("Time:");
	cmd(0xc0);
	show("Date:");
	rtc_int();
	while(1) {
		sec	 =rtc_read_byte(0x00);
		min	 =rtc_read_byte(0x01);
		hour =rtc_read_byte(0x02);
		day	 =rtc_read_byte(0x03);
		date =rtc_read_byte(0x04);
		month=rtc_read_byte(0x05);
		year =rtc_read_byte(0x06);
		
		cmd(0x85);
		dat(convup(hour));
		dat(convd(hour));
		dat(':');
		dat(convup(min));
		dat(convd(min));
		dat(':');
		dat(convup(sec));
		dat(convd(sec));
		
		cmd(0xc5);
		dat(convup(date));
		dat(convd(date));
		dat(':');
		dat(convup(month));
		dat(convd(month));
		dat(':');
		dat(convup(year));
		dat(convd(year));
		dat('/');
		dat(convup(day));
		dat(convd(day));
			
	}
}		
	

void rtc_int()
{
	TRISC3=TRISC4=1;
	SSPCON=0x28;
	SSPADD=	(((11059200/4)/100)-1);
}

void waitmssp()
{
	while(!SSPIF); // SSPIF is zero while TXion is progress    
	SSPIF=0;
}

void rtc_send(unsigned char a)
{
	SSPBUF=a;
	waitmssp();
	while(ACKSTAT);
}	

void rtc_send_byte(unsigned char addr,unsigned char data)
{
	rtc_start();
	rtc_send(0xD0);
	//rtc_send(addr>>8);
	rtc_send(addr);
	rtc_send(data);
	rtc_stop();
}

unsigned char rtc_read()
{
	RCEN=1;
	waitmssp();
	return SSPBUF;
}	
	
unsigned char rtc_read_byte(unsigned char addr)
{
	unsigned char rec;
L:	rtc_res();
	SSPBUF=0xD0;
	waitmssp();
	while(ACKSTAT){goto L;}
	//rtc_send(addr>>8);
	rtc_send(addr);
	rtc_res();
	rtc_send(0xD1);
	rec=rtc_read();
	rtc_nak();
	rtc_stop();
	return rec;
}
	
	
void rtc_start()
{
	SEN=1;
	waitmssp();
}

void rtc_stop()
{
	PEN=1;
	waitmssp();
}

void rtc_res()
{
	RSEN=1;
	waitmssp();
}

void rtc_ack()
{
	ACKDT=0;
	ACKEN=1;
	waitmssp();
}

void rtc_nak()
{
	ACKDT=1;
	ACKEN=1;
	waitmssp();
}

unsigned char convup(unsigned char bcd)
{ 
	return ((bcd>>4)+48);
}

unsigned char convd(unsigned char bcd)
{ 
 	return ((bcd&0x0F)+48);
}	