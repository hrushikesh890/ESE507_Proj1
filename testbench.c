#include<stdio.h>
#include<time.h>
int main()
{
  int inputs = 1000, lower = 0, upper = 1;
  int reset = 0, valid_in, valid_out = 0, f = 0, a, i = 0;
  int nUpper = 255, nLower = 0;
  
  srand(time(NULL));
  FILE *inputdata, *expectedoutput;
  
  inputdata = fopen("inputdata.txt", "w");
  expectedoutput = fopen("expectedoutput.txt", "w");
  
  fprintf(expectedoutput,  "Valid_out = %d f = %d\n", valid_out, f);
  
  for(i = 0; i < inputs; i++)
  {
    a = (rand() % (nUpper - nLower + 1)) + nLower;
    valid_in = (rand() % (upper - lower + 1)) + lower;
    // reset = (rand() % (upper - lower + 1)) + lower; 
    
    fprintf(inputdata,  "Reset = %x valid_in = %x a = %x\n", reset, valid_in, a);
    
    if(reset == 1)
    {
      f=0;
      a=0;
      fprintf(expectedoutput,  "Valid_out = %d f = %d\n", 0, 0);
      fprintf(expectedoutput,  "Valid_out = %d f = %d\n", 0, 0);
    }
    else if(valid_in == 0)
    {
      fprintf(expectedoutput,  "Valid_out = %d f = %d\n", 0, f);
    }
    else
    {
      f += (a * a);
      fprintf(expectedoutput,  "Valid_out = %d f = %d\n", 1, f);
    }
  }
  fclose(inputdata);
  fclose(expectedoutput);
}
      