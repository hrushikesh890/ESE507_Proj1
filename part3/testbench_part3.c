#include<stdio.h>
#include<time.h>
#include<math.h>
int main()
{
  int inputs = 1000, lower = 0, upper = 1;
  int reset = 1, valid_in, valid_out = 0, f = 0, a, i = 0, sq = 0;
  int nUpper = 255, nLower = 0;
  
  srand(time(NULL));
  FILE *inputdata, *expectedoutput;
  
  inputdata = fopen("inputdata_part3.txt", "w");
  expectedoutput = fopen("expectedoutput_part3.txt", "w");
  
  if(reset == 1)
    {
      f=0;
      a=0;
      sq = 0;
      fprintf(expectedoutput,  "%d  %d\n", 0, 0);
      fprintf(expectedoutput,  "%d  %d\n", 0, 0);
      fprintf(expectedoutput,  "%d  %d\n", 0, 0);
    }
    reset = 0;
  
  for(i = 0; i < inputs; i++)
  {
    a = (rand() % (nUpper - nLower + 1)) + nLower;
    valid_in = (rand() % (upper - lower + 1)) + lower;
    // reset = (rand() % (upper - lower + 1)) + lower; 
    
    fprintf(inputdata,  "%x\n%x\n", valid_in, a);

    if(valid_in == 0)
    {
      fprintf(expectedoutput,  "%d  %d\n", 0, sq);
    }
    else
    {
      printf("%d/n",a);
      f += (a * a);
      sq = sqrt(f);
      fprintf(expectedoutput,  "%d  %d\n", 1, (int)sq);
    }
  }
  fclose(inputdata);
  fclose(expectedoutput);
}
      