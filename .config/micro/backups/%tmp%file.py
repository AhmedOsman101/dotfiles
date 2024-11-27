def q1():
  # Loop over numbers from 1 to 12
  for i in range(1, 13):
    # Loop again from 1 to 12 for each number
    for j in range(1, 13):
      # Print the results
      print(f"{i}x{j} = {i*j}")

def q2():
  MAX = 20
  # Loop from 1 to the max number (included)
  for i in range (1, MAX + 1):
    count = 0
    # print the current number and its first divisor (1), the set the end to be a whitespace
    print(f"{i}: 1", end=" ")
    """
    loop over each number from 2 to the current number.
    we can reduce the number of iterations by stopping at `i`;
    because if `i < j` then `i % j` will always be equal to `i`, so we don't have to go beyond `i`
    """
    for j in range (2, i + 1):
      if (i % j == 0):
        print(j, end=" ")
    print("") # To print a new line

q2()
