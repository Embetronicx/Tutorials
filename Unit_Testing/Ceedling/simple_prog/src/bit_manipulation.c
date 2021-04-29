#include "bit_manipulation.h"

uint8_t Jill = 0x00; 
uint8_t Jung = 0xFF; 
uint8_t Jukk = 0x00; 

int8_t do_bit_man(int8_t position) 
{
  if( ( position < 0 ) || ( position > 7 ) )
  { 
    //position should be 0 to 7. Because we are going to modify 8 bit value. 
    return -1; 
  }
  
  //set particular bit
  Jill |= ( 1 << position );

  //clear particular bit
  Jung &= ~( 1 << position );

  //toggle particular bit
  Jukk ^= ( 1 << position );
  
  return 0; 
}