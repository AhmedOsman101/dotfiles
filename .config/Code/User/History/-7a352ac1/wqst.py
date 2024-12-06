def q1():
  Sum = 0
  i = 1
  while i <= 10:
    Sum += i
    i += 1

  print(Sum)

def q2():
  i = 1
  while i % 5 != 0:
    print(f"i: {i}")
    i+= 1
  else:
    print(f"{i} is divisble on 5")


q2()
