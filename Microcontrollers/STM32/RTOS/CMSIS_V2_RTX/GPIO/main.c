/***************************************************************************//**
*  \file       main.c
*
*  \details    LED Blinking using RTX CMSIS V2 RTOS 
*
*  \author     EmbeTronicX
*
*  \Tested with Proteus
*
* *****************************************************************************/ 
#include "RTE_Components.h"
#include  CMSIS_device_header
#include "cmsis_os2.h"
#include "stm32f4xx.h"

 
/*
** This thread will turns ON and turns OFF the PORT-D LEDs with 1second delay.
**
**  Arguments:
**      arg  -> Argument of this thread. osThreadNew()'s 2nd arg has to come here. 
**   
*/
__NO_RETURN static void LED_Blink_PortD( void *arg ) 
{
  (void)arg;                            //unused variable
  //set Port D as output
  GPIOD->MODER = 0x55555555;
  
  for (;;)                              //infinite for loop
  {
    //Turn ON the LED of Port-D
    GPIOD->BSRR = 0x0000FFFF;
    osDelay(1000);                      //1sec delay
    //Turn OFF the LED of Port-D
    GPIOD->BSRR = 0xFFFF0000;
    osDelay(1000);                      //1sec delay
  }
}

/*
** This thread will turns ON and turns OFF the PORT-E LEDs with 3second delay.
**
**  Arguments:
**      arg  -> Argument of this thread. osThreadNew()'s 2nd arg has to come here. 
**   
*/
__NO_RETURN static void LED_Blink_PortE( void *arg ) 
{
  (void)arg;                            //unused variable
  //set Port E as output
  GPIOE->MODER = 0x55555555;
  for (;;)                              //infinite for loop
  {
    //Turn ON the LED of Port-E
    GPIOE->BSRR = 0x0000FFFF;
    osDelay(3000);                      //3sec delay
    //Turn OFF the LED of Port-E
    GPIOE->BSRR = 0xFFFF0000;
    osDelay(3000);                      //3sec delay
  }
}

/*
** main function
**
**  Arguments:
**      none
**   
*/ 
int main (void) 
{
  //Enable the AHB clock all GPIO Port-D
  SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIODEN);
  //Enable the AHB clock all GPIO Port-E
  SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIOEEN);
  
  // System Initialization
  SystemCoreClockUpdate();
 
  osKernelInitialize();                       // Initialize CMSIS-RTOS
  osThreadNew(LED_Blink_PortD, NULL, NULL);   // Create application main thread
  osThreadNew(LED_Blink_PortE, NULL, NULL);   // Create application main thread
  osKernelStart();                            // Start thread execution
  for (;;) 
  {
    //Dummy infinite for loop.
  }
}
