#ifdef TEST

#include "unity.h"

#include "bit_manipulation.h"

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

//Test Case 0 
void test_do_bit_man_0(void) 
{
  int8_t result;
  result = do_bit_man( 15 );

  TEST_ASSERT_EQUAL_INT8( -1, result );
  TEST_ASSERT_EQUAL_INT8( 0x00, Jill );
  TEST_ASSERT_EQUAL_INT8( 0xFF, Jung );
  TEST_ASSERT_EQUAL_INT8( 0x00, Jukk );
}

//Test Case 1 
void test_do_bit_man_1(void) 
{
  int8_t result;

  result = do_bit_man( -5 );

  TEST_ASSERT_EQUAL_INT8( -1, result );
  TEST_ASSERT_EQUAL_INT8( 0x00, Jill );
  TEST_ASSERT_EQUAL_INT8( 0xFF, Jung );
  TEST_ASSERT_EQUAL_INT8( 0x00, Jukk );
}

//Test Case 2 
void test_do_bit_man_2(void) 
{
  int8_t result;
  int8_t position = 5;

  result = do_bit_man( position );

  TEST_ASSERT_EQUAL_INT8( 0, result );
  TEST_ASSERT_BIT_HIGH( position, Jill );
  TEST_ASSERT_BIT_LOW( position, Jung );
  TEST_ASSERT_BIT_HIGH( position, Jukk );
}

#endif // TEST
