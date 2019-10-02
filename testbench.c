#include<stdio.h>
// Created By Nehul Oswal(112820228) and Hrushikesh Patil(112872294)

#include<time.h>
int main()
{
  int inputs = 100000, lower = 0, upper = 1;
  int reset = 1, valid_in, valid_out = 0, f = 0, a, i = 0;
  int nUpper = 255, nLower = 0;
  
  srand(time(NULL));
  FILE *inputdata, *expectedoutput;
  
  inputdata = fopen("inputdata.txt", "w");
  expectedoutput = fopen("expectedoutput.txt", "w");
  
  //fprintf(expectedoutput,  "%d %d\n", valid_out, f);
  
  if(reset == 1)
    {
      f=0;
      a=0;
      fprintf(expectedoutput,  "%d %d\n", 0, 0);
      fprintf(expectedoutput,  "%d %d\n", 0, 0);
    }
    
    reset = 0;
  
  
  for(i = 0; i < inputs; i++)
  {
    a = (rand() % (nUpper - nLower + 1)) + nLower;
    valid_in = (rand() % (upper - lower + 1)) + lower;
    // reset = (rand() % (upper - lower + 1)) + lower; 
    
    fprintf(inputdata,  "%x\n%x\n", valid_in, a);
    
    if(reset == 1)
    {
      f=0;
      a=0;
      fprintf(expectedoutput,  "%d %d\n", 0, 0);
      fprintf(expectedoutput,  "%d %d\n", 0, 0);
    }
    else if(valid_in == 0)
    {
      fprintf(expectedoutput,  "%d %d\n", 0, f);
    }
    else
    {
      f += (a * a);
      f = f%1048576;
      fprintf(expectedoutput,  "%d %d\n", 1, f);
    }
  }
  fclose(inputdata);
  fclose(expectedoutput);
}
      
