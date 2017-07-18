#define trig (1<<8)						//P0.8
#define echo (IO0PIN&(1<<9))			//P0.9 as EINT3

void ultrasonic_init();
void send_pulse();
unsigned int get_range();

void ultrasonic_init()
{
IO0DIR|=(1<<8);
T0CTCR=0;
T0PR=59;
}

void send_pulse()
{
T0TC=T0PC=0;
IO0SET=trig;							//trig=1
timer1delay(10);						//10us delay
IO0CLR=trig;							//trig=0
}

unsigned int get_range()
{
unsigned int get=0;
send_pulse();
while(!echo);
T0TCR=0x01;
while(echo);
T0TCR=0;
get=T0TC;

if(get<38000)
	get=get/59;
else
	get=0;

return get;
}

	