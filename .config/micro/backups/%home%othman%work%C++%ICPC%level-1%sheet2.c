// #include <math.h>
// #include <stdlib.h>
#include <string.h>
#include <stdio.h>

void K() {
  int n, x, y, z, x_sum = 0, y_sum = 0, z_sum = 0;
  scanf("%i", &n);

  

  for (int i = 0; i < n; i++) {
    scanf("%i %i %i", &x, &y, &z);

    x_sum += x;
    y_sum += y;
    z_sum += z;
  }
  
  if(x_sum != 0 || y_sum != 0 || z_sum != 0){
    printf("NO\n");
  } else{
    printf("YES\n");
  }
}

void L() {
  int n, k;
  scanf("%i %i", &n, &k);

  for (int i = 0; i < k; i++) {
    (n % 10 != 0) ? n-- : (n /= 10);
  }
  printf("%i\n", n);
}

int M() {
  int count = 1;
  char str[100];
  fgets(str, sizeof(str), stdin);

  for (size_t i = 0; i < strlen(str) - 1; i++) {
    if (count == 7) {
      printf("YES\n");
      return 0;
    }

    if(str[i] == str[i+1]) count += 1;
    else count = 1;
  }

  printf("NO\n");
  return 0;
}

void N() {
  //
}

void O() {
  //
}

void P() {
  //
}

void Q() {
  //
}

void R() {
  //
}

void S() {
  //
}

void T() {
  //
}

void U() {
  //
}

void V() {
  //
}

void W() {
  //
}

int main() {
  M();
  return 0;
}
