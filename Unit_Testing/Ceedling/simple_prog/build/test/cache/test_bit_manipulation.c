#include "src/bit_manipulation.h"
#include "C:/Ruby25-x64/lib/ruby/gems/2.5.0/gems/ceedling-0.31.0/vendor/unity/src/unity.h"








extern uint8_t Jill;

extern uint8_t Jung;

extern uint8_t Jukk;



void setUp(void)

{

  Jill = 0x00;

  Jung = 0xFF;

  Jukk = 0x00;

}



void tearDown(void)

{

}





void test_do_bit_man_0(void)

{

  int8_t result;

  result = do_bit_man( 15 );



  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((-1)), (UNITY_INT)(UNITY_INT8 )((result)), (

 ((void *)0)

 ), (UNITY_UINT)(28), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0x00)), (UNITY_INT)(UNITY_INT8 )((Jill)), (

 ((void *)0)

 ), (UNITY_UINT)(29), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0xFF)), (UNITY_INT)(UNITY_INT8 )((Jung)), (

 ((void *)0)

 ), (UNITY_UINT)(30), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0x00)), (UNITY_INT)(UNITY_INT8 )((Jukk)), (

 ((void *)0)

 ), (UNITY_UINT)(31), UNITY_DISPLAY_STYLE_INT8);

}





void test_do_bit_man_1(void)

{

  int8_t result;



  result = do_bit_man( -5 );



  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((-1)), (UNITY_INT)(UNITY_INT8 )((result)), (

 ((void *)0)

 ), (UNITY_UINT)(41), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0x00)), (UNITY_INT)(UNITY_INT8 )((Jill)), (

 ((void *)0)

 ), (UNITY_UINT)(42), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0xFF)), (UNITY_INT)(UNITY_INT8 )((Jung)), (

 ((void *)0)

 ), (UNITY_UINT)(43), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0x00)), (UNITY_INT)(UNITY_INT8 )((Jukk)), (

 ((void *)0)

 ), (UNITY_UINT)(44), UNITY_DISPLAY_STYLE_INT8);

}





void test_do_bit_man_2(void)

{

  int8_t result;

  int8_t position = 5;



  result = do_bit_man( position );



  UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((0)), (UNITY_INT)(UNITY_INT8 )((result)), (

 ((void *)0)

 ), (UNITY_UINT)(55), UNITY_DISPLAY_STYLE_INT8);

  UnityAssertBits((UNITY_INT)(((UNITY_UINT)1 << (position))), (UNITY_INT)((UNITY_UINT)(-1)), (UNITY_INT)((Jill)), (

 ((void *)0)

 ), (UNITY_UINT)(56));

  UnityAssertBits((UNITY_INT)(((UNITY_UINT)1 << (position))), (UNITY_INT)((UNITY_UINT)(0)), (UNITY_INT)((Jung)), (

 ((void *)0)

 ), (UNITY_UINT)(57));

  UnityAssertBits((UNITY_INT)(((UNITY_UINT)1 << (position))), (UNITY_INT)((UNITY_UINT)(-1)), (UNITY_INT)((Jukk)), (

 ((void *)0)

 ), (UNITY_UINT)(58));

}
