#define write_cmd 0xA0
#define read_cmd 0xA1

void i2c_init();
void i2c_start();
void i2c_stop();
void i2c_restart();
void i2c_ack();
void i2c_nak();
void waitmssp();
void i2c_send(unsigned char dat);
void i2c_send_byte(unsigned char addr,unsigned char *count);
unsigned char i2c_read();
unsigned char i2c_read_byte(unsigned char addr);

void i2c_init()
{
	TRISC3=TRISC4=1;
	SSPCON=0x28;					//SSP Module as Master
	SSPADD=((11059200/4)/100)-1;	//Setting Clock Speed, My PCLK = 11.0592MHz
}

void i2c_start()
{
	SEN=1;
	waitmssp();
}

void i2c_stop()
{
	PEN=1;
	waitmssp();
}

void i2c_restart()
{
	RSEN=1;
	waitmssp();
}

void i2c_ack()
{
	ACKDT=0;
	ACKEN=1;
	waitmssp();
}

void i2c_nak()
{
	ACKDT=1;
	ACKEN=1;
	waitmssp();
}

void waitmssp()
{
	while(!SSPIF);
	SSPIF=0;
}

void i2c_send(unsigned char dat)
{
L1:	SSPBUF=dat;
	waitmssp();
	while(ACKSTAT){i2c_restart;goto L1;}
}

void i2c_send_byte(unsigned char addr,unsigned char *count)
{
	i2c_start();
	i2c_send(write_cmd);
	i2c_send(addr>>8);
	i2c_send(addr);
	while(*count) {
		i2c_send(*count++);
	}
	i2c_stop();
}

unsigned char i2c_read()
{
	RCEN=1;
	waitmssp();
	return SSPBUF;
}	

unsigned char i2c_read_byte(unsigned char addr)
{
	unsigned char rec;
L:	i2c_restart();
	SSPBUF=write_cmd;
	waitmssp();
	while(ACKSTAT){goto L;}
	i2c_send(addr>>8);
	i2c_send(addr);
	i2c_restart();
	i2c_send(read_cmd);
	rec=i2c_read();
	i2c_nak();
	i2c_stop();
	return rec;
}
