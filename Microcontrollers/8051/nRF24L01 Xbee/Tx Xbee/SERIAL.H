void ser_init(void);
void tx(unsigned char t);
unsigned char rx();
void tx_str(unsigned char *s);

void ser_init()
{
  SCON=0x50;
  TMOD=0x20;
  TH1=TL1=0xfd;
  TR1=1;
}
unsigned char rx()
{
  while(RI==0);
  RI=0;
  return SBUF;
}

void tx(unsigned char t)
{
  SBUF=t;
  while(TI==0);
  TI=0;
}

void tx_str(unsigned char *s)
{
  while(*s)
  tx(*s++);
}
