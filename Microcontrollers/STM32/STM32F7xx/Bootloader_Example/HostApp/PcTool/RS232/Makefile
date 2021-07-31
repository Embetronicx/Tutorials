#
#
# Author: Teunis van Beelen
#
# email: teuniz@protonmail.com
#
#

CC = gcc
CFLAGS = -Wall -Wextra -Wshadow -Wformat-nonliteral -Wformat-security -Wtype-limits -O2

objects = rs232.o

all: test_rx test_tx

test_rx : $(objects) demo_rx.o
	$(CC) $(objects) demo_rx.o -o test_rx

test_tx : $(objects) demo_tx.o
	$(CC) $(objects) demo_tx.o -o test_tx

demo_rx.o : demo_rx.c rs232.h
	$(CC) $(CFLAGS) -c demo_rx.c -o demo_rx.o

demo_tx.o : demo_tx.c rs232.h
	$(CC) $(CFLAGS) -c demo_tx.c -o demo_tx.o

rs232.o : rs232.h rs232.c
	$(CC) $(CFLAGS) -c rs232.c -o rs232.o

clean :
	$(RM) test_rx test_tx $(objects) demo_rx.o demo_tx.o rs232.o

#
#
#
#





