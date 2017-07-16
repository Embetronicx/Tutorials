unsigned int val;
unsigned int adc(int,int);



unsigned int adc(int no,int ch)
{
	switch(no)									  //select adc
	{
		case 0:	AD0CR=0x00200600|(1<<ch);		  //select channel
				AD0CR|=(1<<24);				  //start conversion
				while((AD0GDR& (1<<31))==0);
				val=AD0GDR;
				break;

		case 1:	AD1CR=0x00200600|(1<<ch);		  //select channel
				AD1CR|=(1<<24);				  //start conversion
				while((AD1GDR&(1<<31))==0);
				val=AD1GDR;
				break;
	}
	val=(val >> 6) & 0x03FF; 					 // bit 6:15 is 10 bit AD value

	return val;
}
