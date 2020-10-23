#include"nRF24L01.H"


void main()
{
  unsigned char *rec;
  ser_init();
  nRF_config();
  while(1)
  {
    rec=RX_PL();
    tx_str(rec);
  }
}