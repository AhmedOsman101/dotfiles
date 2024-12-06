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


def q3():
  i = 1
  while i <= 10:
    if i % 2 != 0:
      i+= 1
      continue
    print(i)
    i+= 1

def victoria():
  result = 1
  for i in range(1, int(input("Enter range: ")) + 1):
    
    result *= i
  print(result)

def q4():
  for i in range(1, 13):
    print(f"{i} * {5} = {i*5}")

q4()
