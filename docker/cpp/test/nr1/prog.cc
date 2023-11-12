#include<ios>
unsigned char b,g,r;int main(){scanf("#%x",&b);putchar((r&g&b)>239?49:(r|g|b)<16?48:r>g&r>b?82:g>b?71:66);}
