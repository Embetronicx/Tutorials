/***************************************************************************//**
*   \file       main.c
*
*   \details    Setting all the Ports (A, B, C, D, and E) as output 
*               and toggling them with some random delay              
*
*   \author     EmbeTronicX
*
*   \This code is verified with proteus simulation
*
*******************************************************************************/

#include "stm32f4xx.h" 

#define DELAY_COUNT	( 30000 )   //delay count

/***************************************************************************//**

  \details  Providing Delay by running empty for loop

  \return   void

  \retval   none

*******************************************************************************/
static void delay( void )
{
	uint32_t i = 0;
	for( i=0; i<=DELAY_COUNT; i++ );
}

/***************************************************************************//**

  \details  The main function.  It should not return.

  \return   void

  \retval   none

*******************************************************************************/
int main(void){

	//Enable the AHB clock all GPIO ports
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIOAEN);
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIOBEN);
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIOCEN);
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIODEN);
	SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIOEEN);

	//set all Port A to Port E as output
	GPIOA->MODER = 0x55555555;
	GPIOB->MODER = 0x55555555;
	GPIOC->MODER = 0x55555555;
	GPIOD->MODER = 0x55555555;
	GPIOE->MODER = 0x55555555;

  //Endless loop
	while(1){
		
		//Turn ON the LED of all the ports
		GPIOA->BSRR = 0x0000FFFF;
		GPIOB->BSRR = 0x0000FFFF;
		GPIOC->BSRR = 0x0000FFFF;
		GPIOD->BSRR = 0x0000FFFF;
		GPIOE->BSRR = 0x0000FFFF;

		delay();

		//Turn OFF the LED of all the ports
		GPIOA->BSRR = 0xFFFF0000;
		GPIOB->BSRR = 0xFFFF0000;
		GPIOC->BSRR = 0xFFFF0000;
		GPIOD->BSRR = 0xFFFF0000;
		GPIOE->BSRR = 0xFFFF0000;

		delay();
	}
}
