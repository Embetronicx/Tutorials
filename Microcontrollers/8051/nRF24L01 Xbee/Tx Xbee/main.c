#include"nRF24L01.H"
#define delay for(i=0;i<5000;i++)

unsigned int i;

void main()
{
  unsigned char a;
  ser_init();
  nRF_config();
  while(1)
  {
    a=rx();
    TX_PL(&a);
    //delay;
  }
}