#include<iostream.h>
#include<conio.h>
int main()
{
  clrscr();
  int Array[20],n;
  cout << "Enter the number of elements :  ";
  cin >> n;
  for(int i =  0  ; i < n ; i++){
    cin >> Array[i];

  }
  int temp;
  int min = Array[0];
  for(i = 1 ; i < n ; i++){
       temp =  Array[i];
       asm   mov ax , temp;
       asm cmp min , ax;
      asm  jc label1
      label2:
      asm mov min ,ax;

       label1 :
       asm inc si;

  }
  cout << "\nMinimum = "<<min<<endl;




  getch();
return 0;
}