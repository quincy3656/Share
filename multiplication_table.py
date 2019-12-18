#!/usr/bin/python3
"""

THIS DOES STUFF WITH NUMBERS

"""
number = int(input("What number would like to see the multiplication table for? "))
stop = int(input("How many rows would you like? "))
START = 1
STEP = 1

#The below ensures the range is inclusive and thus would work intuitively to the user.
stop +=STEP

print("="*25)
for i in range(START,stop,STEP):
    print(i,":",i*number)
print("="*25)
