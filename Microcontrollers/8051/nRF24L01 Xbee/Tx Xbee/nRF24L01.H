#include<intrins.h>
#include<reg51.h>
#include"SERIAL.H"

#define TX_mode                      //If u want to receive Change to RX_mode 

sbit MISO = P1^0;                    //SPI signal
sbit MOSI = P1^1;                    //SPI signal
sbit SCK  = P1^2;                    //SPI signal-Clk
sbit CSN  = P1^3;                    //SPI signal-Chip select
sbit CE   = P1^4;                    //this signal is active high and is used to activate the chip in RX or TX mode

//Commands
#define  R_REG       0x00            //Read command from reg
#define W_REG        0x20            //Write command to reg
#define R_RX_PL      0x61            //RX payload register address
#define W_TX_PL      0xA0            //TX payload register address
#define FLUSH_TX     0xE1            //Flush TX register 
#define FLUSH_RX     0xE2            //Flush RX register 
#define REUSE_TX_PL  0xE3            //Reuse TX payload register
#define NOP          0xFF            //No operation, might be used to read status register

//Register Address
#define CONFIG       0x00            //'Config' Reg  
#define EN_AA        0x01            //Enable Auto Ack Reg 
#define EN_RXADDR    0x02            //Enabled RX Addresses Reg
#define SETUP_AW     0x03            //Setup of Address Widths Reg
#define SETUP_PETR   0x04            //Setup of Automatic Retransmission Reg
#define RF_CH        0x05            //RF Channel Reg
#define RF_SETUP     0x06            //RF Setup Reg
#define STATUS       0x07            //Status Reg
#define OBSERVE_TX   0x08            //Transmit observe Reg
#define CD           0x09            //Carrier Detect Reg
#define RX_ADDR_P0   0x0A            //Receive address data pipe 0
#define RX_ADDR_P1   0x0B            //Receive address data pipe 1
#define RX_ADDR_P2   0x0C            //Receive address data pipe 2
#define RX_ADDR_P3   0x0D            //Receive address data pipe 3
#define RX_ADDR_P4   0x0E            //Receive address data pipe 4
#define RX_ADDR_P5   0x0F            //Receive address data pipe 5
#define TX_ADDR      0x10            //Transmit address. Used for a PTX device only
#define RX_PW_P0     0x11            //RX payload width, pipe 0 
#define RX_PW_P1     0x12            //RX payload width, pipe 1
#define RX_PW_P2     0x13            //RX payload width, pipe 2
#define RX_PW_P3     0x14            //RX payload width, pipe 3
#define RX_PW_P4     0x15            //RX payload width, pipe 4
#define RX_PW_P5     0x16            //RX payload width, pipe 5
#define FIFO_STATUS  0x17            //FIFO Status Reg

#define TX_PLOAD_WIDTH 1
#define TX_ADD_WIDTH   5

const unsigned char TX_ADDRESS[TX_ADD_WIDTH] ={'i','n','t','e','r'}; 
unsigned char read_buf[TX_PLOAD_WIDTH+1]; 

volatile unsigned char bdata ack;
sbit RX_DR=ack^6;
sbit TX_DS=ack^5;
sbit MAX_RT=ack^4;

volatile unsigned char bdata buffer;
sbit msb = buffer^7;
sbit lsb = buffer^0;
 
void spi_delay(void);                                                                 //Delay 
void nRF_config(void);                                                                //Select RX or TX
unsigned char spi_W(unsigned char);                                                   //Write byte and read the status
unsigned char spi_WREG(unsigned char,unsigned char);                                  //Write byte to REG and Read Status
unsigned char spi_WBUF(unsigned char reg,unsigned char *buff ,unsigned char count);   //Write the no of char to REG
unsigned char spi_RREG(unsigned char);                                                //Read the REG that have one byte
void spi_RBUF(unsigned char reg,unsigned char count);                                 //Read the REG that have more than one byte

unsigned char TX_PL(const unsigned char *payload);                                    //Transmit payload
unsigned char* RX_PL(void);                                                           //Receive payload

void get_status(void);                                                                //Get the status
void clear_irq(void);                                                                 //Clear IRQ bits (TX_DS, MAX_RT, RX_DR)

void spi_delay()
{
  _nop_();_nop_();_nop_();_nop_();_nop_();_nop_();_nop_();
  _nop_();_nop_();_nop_();_nop_();_nop_();_nop_();_nop_();
}

void get_status(void)
{
  ack=0;
  ack=spi_RREG(STATUS);        
}

void clear_irq()
{
  spi_WREG(W_REG|STATUS,0x70);              //Clear RX_DR, TX_DS, MAX_RT flags
}

void nRF_config()
{
  CE=0;                             //Chip enable
  CSN=1;                            //SPI disable
  SCK=0;                            //SPI clock line init high 


#ifdef TX_mode 
  spi_WBUF(W_REG|TX_ADDR,TX_ADDRESS,TX_ADD_WIDTH);      //Set static TX address
  spi_WBUF(W_REG|RX_ADDR_P0,TX_ADDRESS,TX_ADD_WIDTH);   //Set static RX address for auto ack
#endif

#ifdef RX_mode
  CE=0;
  spi_WREG(FLUSH_RX,NOP);                                 //Clear the RX_FIFO
  spi_WREG(W_REG|CONFIG,0x0F);                            //Set PWR_UP bit, enable CRC(2 bytes) & Prim:RX. RX_DR enabled  
  spi_WREG(W_REG|EN_AA,0x01);                             //Enable ShockBurst (Enable Auto ACK)    
  spi_WREG(W_REG|SETUP_AW,0x03);                          //Puts the address field width 5bytes  
  spi_WREG(W_REG|RF_CH,0x6E);                             //Set frequency channel 110 (2.510MHz)
  spi_WREG(W_REG|RF_SETUP,0x06);                          //Setup: 1Mbps, 0dBm, LNA off  
  spi_WREG(W_REG|EN_RXADDR,0x01);                         //Enable data pipe 0                  
  spi_WBUF(W_REG|RX_ADDR_P0,TX_ADDRESS,TX_ADD_WIDTH);     //Set static RX address
  spi_WREG(W_REG|RX_PW_P0,TX_PLOAD_WIDTH);                //Set RX payload length
  CE=1;
#endif
}

unsigned char spi_W(unsigned char buf)
{
  int sp;
  buffer=buf;
  for(sp=0;sp<=7;sp++)
  {
    MOSI=msb;                     //MSB to MOSI-OUTPUT
    buffer=buffer<<1;
    SCK=1;
    buffer&=0xfe;                //Clear 0th bit
    buffer|=MISO;                //capture current MISO bit
    SCK=0;  
  }
  return buffer;
}

unsigned char spi_WREG(unsigned char reg,unsigned char value)
{
  unsigned char stat;
  CSN=0;                      //CSN low, init SPI transaction 
  stat=spi_W(reg);            //Select Reg
  spi_W(value);               //Send Value
  CSN=1;                      //CSN high
  return stat;
}

unsigned char spi_WBUF(unsigned char reg,unsigned char *buff ,unsigned char count)
{
  unsigned char stat,sp;
  CSN=0;
  stat=spi_W(reg);
  for(sp=0;sp<count;sp++)
  {
    spi_W(buff[sp]);
  }
  CSN=1;
  return stat;
}

#ifdef TX_mode
unsigned char TX_PL(unsigned char *payload)
{
  unsigned char stat;
  clear_irq();
  CE=0;        
  spi_WREG(FLUSH_TX,NOP);                    //Clear the TX_FIFO
  spi_WREG(W_REG|CONFIG,0x00);               //PRIM_RX : PTX
  spi_WREG(W_REG|EN_AA,0x01);                //Enable ShockBurst (Enable Auto ACK)
  spi_WREG(W_REG|EN_RXADDR,0x01);            //Enable data pipe 0
  spi_WREG(W_REG|SETUP_AW,0x03);             // Puts the address field width 5bytes
  spi_WREG(W_REG|SETUP_PETR,0x1A);           //Auto retransmit: wait 500us, 10 retries
  spi_WREG(W_REG|RF_CH,0x6E);                //Set frequency channel 110 (2.510MHz)
  spi_WREG(W_REG|RF_SETUP,0x06);             //Setup: 1Mbps, 0dBm, LNA off 
  spi_WREG(W_REG|CONFIG,0x0E);               //Set PWR_UP bit, enable CRC(2 bytes) & Prim:TX. MAX_RT & TX_DS enabled 
  spi_WBUF(W_TX_PL,payload,TX_PLOAD_WIDTH);  //Write specified buffer to FIFO

  CE=1;
  spi_delay();
  CE=0;
  get_status();
  if(MAX_RT)
    return 0;  
  if(TX_DS)
    return 1; 
  return stat;  
}
#endif

unsigned char spi_RREG(unsigned char reg)
{
  unsigned char rd;
  CSN=0;
  spi_W(reg);
  rd=spi_W(0);
  CSN=1;
  return rd;
}

#ifdef RX_mode
void spi_RBUF(unsigned char reg,unsigned char count)
{
  unsigned char stat,sp;
  CSN = 0;                        // Set CSN low, init SPI tranaction
  stat=spi_W(reg);
  for(sp=0;sp<count;sp++)
  {
    read_buf[sp]=spi_W(0);
  }
  read_buf[sp]='\0';
  CSN = 1;                        // Set CSN high again
}


unsigned char* RX_PL()
{
  spi_WREG(FLUSH_RX,NOP);
  do
  {
    get_status();
  }while(RX_DR==0);
  if(RX_DR)
  {
    clear_irq();
    get_status();
    if(ack ==0)
    {
      spi_RBUF(R_RX_PL,TX_PLOAD_WIDTH);
      spi_delay();
      return read_buf;
    }
  }    
}
#endif