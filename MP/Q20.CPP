#include<conio.h>
#include<iostream.h>
int main(){
  clrscr();
  int numbers[20],n;
  cout << "Enter value of n : ";
  cin >> n;

  for(int i = 0 ; i < n ; i++){
    cin >> numbers[i];

  }
  int quotient = 0 , remainder = 0 , temp;
  int total = 0;
  //asm mov ax , 0;

  for( i = 0 ; i < n ; i++){

    //asm mov temp , ax;
    //cout << "ax => "<<temp<<" ";

    temp =  numbers[i];
    //cout << "temp => "<<temp <<"  " ;
    //asm mov bx , temp;


     //asm mov temp , ax;
     //cout << temp <<"***";
     asm mov ax , total;
     asm add ax , temp;
     asm  mov total , ax;
    /*
     asm add ax , temp;
     asm mov temp , ax;
     cout << "ax = "<<temp << "\n";
     */
  }
 // cout << "----"<<endl;
  //asm mov temp , ax;

 // cout <<temp<<endl;
  asm mov ax , total;
  asm mov bx , n;
  asm mov dx , 0000;
  asm div bx;
  asm mov quotient , ax;
 asm  mov remainder , dx;



   cout <<"Quotient = "<<quotient << " Remainder =  "<<remainder<<endl;
   cout <<"Average = "<<(((float)remainder)/n + quotient) <<endl;


  getch();
  return 0;
}