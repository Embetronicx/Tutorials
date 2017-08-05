#define rs RB0
#define rw RB1
#define en RB2
#define delay for(i=0;i<1000;i++)

int i;

void lcd_init();
void cmd(unsigned char a);
void dat(unsigned char b);
void show(unsigned char *s);

void lcd_init()
{
	TRISD=TRISB=0;
	cmd(0x38);
	cmd(0x0c);
	cmd(0x06);
	cmd(0x80);
}

void cmd(unsigned char a)
{
	PORTD=a;
	rs=0;
	rw=0;
	en=1;
	delay;
	en=0;
}

void dat(unsigned char b)
{
	PORTD=b;
	rs=1;
	rw=0;
	en=1;
	delay;
	en=0;
}

void show(unsigned char *s)
{
	while(*s) {
		dat(*s++);
	}
}
		
	