#include <iostream>
#include <math.h>
// #include <string.h>
#include <iomanip>

using namespace std;

void A()
{
  string name;
  cin >> name;
  cout << "Hello, " << name << endl;
}

void B()
{
  const double PI = 3.141592653;
  double R;
  cin >> R;
  cout << fixed << setprecision(9) << pow(R, 2) * PI << endl;
}

void C()
{
  long a, b, c, d;
  cin >> a >> b >> c >> d;
  cout << a * b * c * d << endl;
}

void D()
{
  string n1, n2;
  cin >> n1 >> n2;
  /*
    stoi method from the string library converts strings to integers,
    but using n1[index] returns a char data type which is not compatible with stoi,
    so I converted it to a string using string method which accepts the length of the string and the value
  */
  int sum = stoi(string(1, n1[n1.length() - 1])) + stoi(string(1, n2[n2.length() - 1]));
  cout << sum << endl;
}

void E()
{
  int k, x;
  cin >> k >> x;

  string response = (k * 500 >= x) ? "Yes" : "No";

  cout << response << endl;
}

void F()
{
  long long a, b, c, d, minLeft, minRight;
  string minlName, minrName, min;
  cin >> a >> b >> c >> d;

  minLeft = (a < b) ? a : b;
  minlName = (a < b) ? "A" : "B";

  if (a == b) minlName = "Equal";

  minRight = (c < d) ? c : d;
  minrName = (c < d) ? "C" : "D";

  if (c == d) minrName = "Equal";

  min = (minLeft < minRight) ? minlName : minrName;
  if (minLeft == minRight) min = "Equal";

  cout << min << endl;
}

void G(){
  
}

int main()
{
  // A();
  // B();
  // C();
  // D();
  // E();
  F();
  return 0;
}
