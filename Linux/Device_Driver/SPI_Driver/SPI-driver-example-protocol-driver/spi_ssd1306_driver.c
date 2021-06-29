/****************************************************************************//**
*  \file       spi_ssd1306_driver.c
*
*  \details    Simple linux driver (SPI Slave Protocol Driver)
*
*  \author     EmbeTronicX
*
*  \Tested with Linux raspberrypi 5.10.27-v7l-embetronicx-custom+
*
*******************************************************************************/
#include <linux/init.h>
#include <linux/module.h>
#include <linux/spi/spi.h>
#include <linux/delay.h>

#include "ssd1306.h"

static struct spi_device *etx_spi_device;

//Register information about your slave device
struct spi_board_info etx_spi_device_info = 
{
  .modalias     = "etx-spi-ssd1306-driver",
  .max_speed_hz = 4000000,              // speed your device (slave) can handle
  .bus_num      = SPI_BUS_NUM,          // SPI 1
  .chip_select  = 0,                    // Use 0 Chip select (GPIO 18)
  .mode         = SPI_MODE_0            // SPI mode 0
};

/****************************************************************************
 * Name: etx_spi_write
 *
 * Details : This function writes the 1-byte data to the slave device using SPI.
 ****************************************************************************/
int etx_spi_write( uint8_t data )
{
  int     ret = -1;
  uint8_t rx  = 0x00;
  
  if( etx_spi_device )
  {    
    struct spi_transfer	tr = 
    {
			.tx_buf	= &data,
      .rx_buf = &rx,
			.len		= 1,
		};

    spi_sync_transfer( etx_spi_device, &tr, 1 );
  }
  
  //pr_info("Received = 0x%02X \n", rx);
  
  return( ret );
}

/****************************************************************************
 * Name: etx_spi_init
 *
 * Details : This function Register and Initilize the SPI.
 ****************************************************************************/
static int __init etx_spi_init(void)
{
  int     ret;
  struct  spi_master *master;
  
  master = spi_busnum_to_master( etx_spi_device_info.bus_num );
  if( master == NULL )
  {
    pr_err("SPI Master not found.\n");
    return -ENODEV;
  }
   
  // create a new slave device, given the master and device info
  etx_spi_device = spi_new_device( master, &etx_spi_device_info );
  if( etx_spi_device == NULL ) 
  {
    pr_err("FAILED to create slave.\n");
    return -ENODEV;
  }
  
  // 8-bits in a word
  etx_spi_device->bits_per_word = 8;

  // setup the SPI slave device
  ret = spi_setup( etx_spi_device );
  if( ret )
  {
    pr_err("FAILED to setup slave.\n");
    spi_unregister_device( etx_spi_device );
    return -ENODEV;
  }
  
  //Initialize the OLED SSD1306
  ETX_SSD1306_DisplayInit();
  
  /* Print the String */
  ETX_SSD1306_SetBrightness( 255 );           // Full brightness
  ETX_SSD1306_InvertDisplay( false );         // Invert the dispaly : OFF
  
  // Enable the Horizontal scroll for first 3 lines
  ETX_SSD1306_StartScrollHorizontal( true, 0, 2);
  
  
  ETX_SSD1306_SetCursor(0,0);                 // Set cursor at 0th line 0th col
  //Write String to OLED
  ETX_SSD1306_String("Welcome\nTo\nEmbeTronicX\n");
  
  ETX_SSD1306_SetCursor(4,35);                // Set cursor at 4th line 35th col
  //Write String to OLED
  ETX_SSD1306_String("SPI Linux\n");
  ETX_SSD1306_SetCursor(5,23);                // Set cursor at 5th line 23rd col
  ETX_SSD1306_String("Device Driver\n");
  ETX_SSD1306_SetCursor(6,37);                // Set cursor at 6th line 37th col
  ETX_SSD1306_String("Tutorial\n");
  
  msleep(9000);                               // 9secs delay
  
  ETX_SSD1306_ClearDisplay();                 // Clear Display
  ETX_SSD1306_DeactivateScroll();             // Deactivate the scroll
  
  /* Print the Image */
  ETX_SSD1306_PrintLogo();
  
  pr_info("SPI driver Registered\n");
  return 0;
}
 
/****************************************************************************
 * Name: etx_spi_exit
 *
 * Details : This function Unregister and DeInitilize the SPI.
 ****************************************************************************/
static void __exit etx_spi_exit(void)
{ 
  if( etx_spi_device )
  {
    // Clear the display
    ETX_SSD1306_ClearDisplay();                 // Clear Display
    ETX_SSD1306_DisplayDeInit();                // Deinit the SSD1306
    spi_unregister_device( etx_spi_device );    // Unregister the SPI slave
    pr_info("SPI driver Unregistered\n");
  }
}
 
module_init(etx_spi_init);
module_exit(etx_spi_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("EmbeTronicX <embetronicx@gmail.com>");
MODULE_DESCRIPTION("A simple device driver - SPI Slave Protocol Driver");
MODULE_VERSION("1.44");

