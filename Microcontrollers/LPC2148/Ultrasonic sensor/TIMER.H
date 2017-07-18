void timer0delay(unsigned int a);
void timer1delay(unsigned int b);

void timer0delay(unsigned int a)	//1ms
{
T0CTCR=0X0000;
T0PR=59999;
T0MR0=a;
T0MCR=0x00000004;
T0TCR=0X02;
T0TCR=0X01;
while(T0TC!=T0MR0);
T0TC=0;
}

void timer1delay(unsigned int b)   //1us
{
T1CTCR=0X0000;
T1PR=59;
T1MR0=b;
T1MCR=0x00000004;
T1TCR=0X02;
T1TCR=0X01;
while(T1TC!=T1MR0);
T1TC=0;
}
