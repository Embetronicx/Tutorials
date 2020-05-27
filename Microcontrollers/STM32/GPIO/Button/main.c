/***************************************************************************//**
*   \file       main.c
*
*   \details    Setting PORT D0 to D3 as output and PORT A0 as input.
*               When we press the Port A0, we will turn on the PD0-PD3.
*
*   \author     EmbeTronicX
*
*   \This code is verified with proteus simulation
*
*******************************************************************************/

#include "stm32f4xx.h" 


/***************************************************************************//**

  \details  The main function.  It should not return.

  \return   void

  \retval   none

*******************************************************************************/
int main(void){

	//Enable the AHB clock all GPIO PORT A and PORT D
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIOAEN);
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIODEN);

	//set Port A as input
	GPIOA->MODER = 0x00000000;
  //Enable Pullup on PA0
  GPIOA->PUPDR = 0x00000001;
  
  //set PORTD0 to PORTD3 as output
	GPIOD->MODER = 0x00000055;
  
  //Turn OFF the LEDs of PORTD 
  GPIOD->BSRR = 0xFFFF0000;

  //Endless loop
	while(1){
		
    //Button is connected to PA0. So we need to check bit 0 of IDR register.
    if( ( GPIOA->IDR & 0x01) == 0 )   
    {
      //Turn ON the LEDs
      GPIOD->BSRR = 0x0000000F;
    }
    else
    {
      //Turn OFF the LEDs 
      GPIOD->BSRR = 0x000F0000;
    }
	}
}
