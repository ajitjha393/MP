#include<iostream.h>
#include<conio.h>
int main(){
  clrscr();
  int a , b ,gcd,lcm;
  cout << "Enter a : ";
  cin >> a;
  cout << "Enter b : ";
  cin >> b;
  asm mov ax , a;
  asm mov bx , b;

  condition_label:
  asm cmp ax , bx;
  asm je ans
 asm jc case1

  case2:
 asm  sub ax , bx
 asm  jmp condition_label

  case1:

  asm sub bx , ax
  asm jmp condition_label;

  ans:
  asm mov gcd , ax;
  cout <<"GCD = "<<gcd<<endl;
  cout <<"LCM = "<<(a*b/gcd)<<endl;
   getch();

  return 0;
}