void serial_init();
void tx(unsigned char dat);
unsigned char rx();
void tx_string(unsigned char *s);

void serial_init()
{
	TRISC6=TRISC7=1;
	TXSTA=0b00100010;
	RCSTA=0b10010000;
	SPBRG=17;
	TXIF=RCIF=0;
}
	
void tx(unsigned char dat)
{
	TXREG=dat;
	while(!TXIF);
}

unsigned char rx()
{
	while(!RCIF);
	return RCREG;
}

void tx_string(unsigned char *s)
{
	while(*s)
	{
		tx(*s++);
	}
}				