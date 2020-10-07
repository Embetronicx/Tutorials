/***************************************************************************//**
*  \file       driver_bus.c
*
*  \details    Simple I2C Bus driver explanation
*
*  \author     EmbeTronicX
*
*  \Tested with Linux raspberrypi 5.4.51-v7l+
*
* *******************************************************************************/
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/delay.h>
#include <linux/kernel.h>
#include <linux/gpio.h>
#include <linux/i2c-algo-bit.h>

#define ADAPTER_NAME     "ETX_I2C_ADAPTER"

#define SCL_GPIO  20    //GPIO act as SCL
#define SDA_GPIO  21    //GPIO act as SDA

/*
** Function to read the SCL GPIO
*/
static int ETX_I2C_Read_SCL(void *data)
{
  gpio_direction_input(SCL_GPIO);
  return gpio_get_value(SCL_GPIO);
}

/*
** Function to read the SDA GPIO
*/
static int ETX_I2C_Read_SDA(void *data)
{
  gpio_direction_input(SDA_GPIO);
  return gpio_get_value(SDA_GPIO);
}

/*
** Function to set the SCL GPIO
*/
static void ETX_I2C_Set_SCL(void *data, int state)
{
  gpio_direction_output(SCL_GPIO, state);
  gpio_set_value(SCL_GPIO, state);
}

/*
** Function to set the SDA GPIO
*/
static void ETX_I2C_Set_SDA(void *data, int state)
{
  gpio_direction_output(SDA_GPIO, state);
  gpio_set_value(SDA_GPIO, state);
}

/*
** Function to Initialize the GPIOs
*/
static int ETX_I2C_Init( void )
{
  int ret = 0;

  pr_info("In %s\n", __func__);
  do      //Break if any error
  {
    //Checking the SCL GPIO is valid or not
    if(gpio_is_valid(SCL_GPIO) == false){
          pr_err("SCL GPIO %d is not valid\n", SCL_GPIO);
          ret = -1;
          break;
    }

    //Checking the SDA GPIO is valid or not
    if(gpio_is_valid(SDA_GPIO) == false){
          pr_err("SDA GPIO %d is not valid\n", SDA_GPIO);
          ret = -1;
          break;
    }
    
    //Requesting the SCL GPIO
    if(gpio_request(SCL_GPIO,"SCL_GPIO") < 0){
          pr_err("ERROR: SCL GPIO %d request\n", SCL_GPIO);
          ret = -1;
          break;
    }

    //Requesting the SDA GPIO
    if(gpio_request(SDA_GPIO,"SDA_GPIO") < 0){
          pr_err("ERROR: SDA GPIO %d request\n", SDA_GPIO);
          //free already requested SCL GPIO
          gpio_free(SCL_GPIO);
          ret = -1;
          break;
    }
    
    /*
    ** configure the SCL GPIO as output, We will change the 
    ** direction later as per our need.
    */
    gpio_direction_output(SCL_GPIO, 1);

    /*
    ** configure the SDA GPIO as output, We will change the 
    ** direction later as per our need.
    */
    gpio_direction_output(SDA_GPIO, 1);

  } while(false);

  return ret;  
}

/*
** Function to Deinitialize the GPIOs
*/
static void ETX_I2C_DeInit( void )
{
  //free both the GPIOs
  gpio_free(SCL_GPIO);
  gpio_free(SDA_GPIO);
}

/*
** I2C bit algorithm Structure
*/
struct i2c_algo_bit_data etx_bit_data = {
  .setsda = ETX_I2C_Set_SDA,
  .setscl = ETX_I2C_Set_SCL,
  .getscl = ETX_I2C_Read_SCL,
  .getsda = ETX_I2C_Read_SDA,
  .udelay = 5,
  .timeout = 100,		/* 100 ms */
};

/*
** I2C adapter Structure
*/
static struct i2c_adapter etx_i2c_adapter = {
  .owner      = THIS_MODULE,
  .class      = I2C_CLASS_HWMON | I2C_CLASS_SPD,
  .name       = ADAPTER_NAME,
  .algo_data  = &etx_bit_data,
  .nr         = 5,
};


/*
** Module Init function
*/
static int __init etx_driver_init(void)
{
  int ret = -1;
  
  ETX_I2C_Init();
  
  ret = i2c_bit_add_numbered_bus(&etx_i2c_adapter);

  pr_info("Bus Driver Added!!!\n");

  return ret;
}

/*
** Module Exit function
*/
static void __exit etx_driver_exit(void)
{
  ETX_I2C_DeInit();
  i2c_del_adapter(&etx_i2c_adapter);
  pr_info("Bus Driver Removed!!!\n");
}

module_init(etx_driver_init);
module_exit(etx_driver_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("EmbeTronicX <embetronicx@gmail.com>");
MODULE_DESCRIPTION("Simple I2C Bus driver explanation");
MODULE_VERSION("1.39");
