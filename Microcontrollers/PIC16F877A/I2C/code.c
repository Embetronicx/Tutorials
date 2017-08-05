#include<pic.h>
#include"lcd.h"
#include"i2c.h"

__CONFIG( FOSC_HS & WDTE_OFF & PWRTE_OFF & CP_OFF & BOREN_ON & LVP_OFF & CPD_OFF & WRT_OFF & DEBUG_OFF);

void delay1();

void main()
{
	lcd_init();
	i2c_init();
	show("  I2C TuTorial  ");
	cmd(0xc2);
	show("Writing...");
	i2c_send_byte(0x0000,"EmbeTronicX");
	delay1();
	cmd(0xc2);
	show("Reading...");
	delay1();
	cmd(0xc2);
	dat(i2c_read_byte(0x0000));
	dat(i2c_read_byte(0x0001));
	dat(i2c_read_byte(0x0002));
	dat(i2c_read_byte(0x0003));
	dat(i2c_read_byte(0x0004));
	dat(i2c_read_byte(0x0005));
	dat(i2c_read_byte(0x0006));
	dat(i2c_read_byte(0x0007));
	dat(i2c_read_byte(0x0008));
	dat(i2c_read_byte(0x0009));
	dat(i2c_read_byte(0x000a));
	
	while(1);
}	

void delay1()
{
	unsigned int j,k;
	for(j=0;j<60000;j++) {
		for(k=0;k<2;k++);
	}
}