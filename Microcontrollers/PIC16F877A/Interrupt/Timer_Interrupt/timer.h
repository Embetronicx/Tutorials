void timer_int();
void t0delay(unsigned int);
void t1delay(unsigned int);
void t2delay(unsigned int);


void timer_int()
{
	OPTION_REG=0b00000111;		//internal clk,rising edge,prescaler with tim0,256
	T1CON=0b00000000;			//prescale=1,oscilator is off,internal clk,timer off
	T2CON=0b01111000;			//postscale=16,prescale=1,timer off
}


void t0delay(unsigned int a)
{
	unsigned int i;
	for(i=0;i<a;i++)
	{
		while(!TMR0IF);
		TMR0IF=0;
	}
}
	

void t1delay(unsigned int b)
{
	unsigned int i;
	T1CON|=(1<<0);				//timer1 on
	for(i=0;i<b;i++)
	{
		TMR1H=TMR1L=0;
		while(!TMR1IF);
		TMR1IF=0;
	}
}		
	

void t2delay(unsigned int c)
{
	unsigned int i;
	T2CON|=(1<<2);				//timer2 on
	for(i=0;i<c;i++)
	{
		while(!TMR2IF);	
		TMR2IF=0;
	}
}			