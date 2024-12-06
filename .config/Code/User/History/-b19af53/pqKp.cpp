#include <iostream>
#include <math.h>
#include <string.h>
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

  if (a == b)
    minlName = "Equal";

  minRight = (c < d) ? c : d;
  minrName = (c < d) ? "C" : "D";

  if (c == d)
    minrName = "Equal";

  min = (minLeft < minRight) ? minlName : minrName;
  if (minLeft == minRight)
    min = "Equal";

  cout << min << endl;
}

void G()
{
  string s;
  int max = 0, count = 0;
  cin >> s;

  for (short i = 0; i < 3; i++)
  {
    if (s[i] == 'R')
    {
      count++;
      max = count;
    }
    else
      count = 0;
  }

  cout << max << endl;
}

void H()
{
  float V, T, S, D;
  cin >> V >> T >> S >> D;
  float time = D / V;

  cout << ((time < T || S < time) ? "Yes" : "No") << endl;
}

void I()
{
  long long n, k, half;
  cin >> n >> k;

  half = ceil((double)n / 2);

  cout << ((k > half) ? (k - half) * 2 : (k * 2) - 1) << endl;
}

void J()
{
  int w;
  cin >> w;

  cout << ((w % 2 == 0 && w > 2) ? "YES" : "NO") << endl;
}

void K()
{
  string n;
  cin >> n;
  int iterations, len = n.length();

  iterations = ceil((float)len / 2);
  iterations = len % 2 == 0 ? iterations : iterations - 1;

  for (int i = 0; i < iterations; i++)
  {
    int j = iterations * 2 - i;

    if (n[i] != n[j])
    {
      cout << "No" << endl;
      return;
    }
  }

  cout << "Yes" << endl;
}

void L()
{
  int A, B;
  cin >> A >> B;

  if (0 < A && B == 0)
  {
    cout << "Gold" << endl;
  }
  else if (A == 0 && 0 < B)
  {
    cout << "Silver" << endl;
  }
  else if (0 < A && 0 < B)
  {
    cout << "Alloy" << endl;
  }
}

void M()
{
  int d, steps = 0, i = 5;
  cin >> d;

  while (d != 0)
  {
    if (0 <= d - i)
    {
      d -= i;
      steps++;
    }
    else
      i--;
  }

  cout << steps << endl;
}

void N()
{
  int A, B;
  cin >> A >> B;

  cout << ((float)A / 100) * B << endl;
}

void O()
{
  int M;
  cin >> M;

  cout << (M == 0 ? 24 : 48 - M) << endl;
}

void P()
{
  double A, B;
  cin >> A >> B;

  cout << fixed << setprecision(6) << ((A - B) / 3) + B << endl;
}

void Q()
{
  int t, a, b, c;

  cin >> t;

  for (int i = 0; i < t; i++)
  {
    cin >> a >> b >> c;

    cout << (a + b == c ? '+' : '-') << endl;
  }
}

void R()
{
  int t, a, b, c;

  cin >> t;

  for (int i = 0; i < t; i++)
  {
    cin >> a >> b >> c;

    cout << ((a + b == c || a + c == b || b + c == a) ? "YES" : "NO") << endl;
  }
}

void S()
{
  int t, x = 0;
  string cmd;

  cin >> t;

  for (int i = 0; i < t; i++)
  {
    cin >> cmd;

    if (cmd[0] == '+')
    {
      ++x;
    }
    else if (cmd[0] == '-')
    {
      --x;
    }
    else if (cmd[0] == 'X'){
      if (cmd[1] == '+')
      {
        ++x;
      }
      else if (cmd[1] == '-')
      {
        --x;
      }
    }
  }
}

int main()
{
  /*

  A();
  B();
  C();
  D();
  E();
  F();
  G();
  H();
  I();
  J();
  K();
  L();
  M();
  N();
  O();
  P();
  Q();
  R();
  */
  S();
  return 0;
}