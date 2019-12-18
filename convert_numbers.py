#!/usr/bin/python3

whatDoyouwant=int(input("I convert numbers of various types into others.\nPlease enter the number for what you need done. \n1 for integer to Hex \n2 for Hex to integer \n3 for integer to binary \n4 for binary to integer \n5 integer to octal \n6 for octal to integer.\nYour choice: "))
exitMessage=("Here is your converted number! ")


#1 for integer to hex
if whatDoyouwant==1:
    convertMe=int(input("Please provide the integer you need converted to hex: "))
    converted=(hex(convertMe))
    print(exitMessage)
    print(converted)

#2 for Hex to integer
elif whatDoyouwant==2:
    convertMe=input("Please provide the hexadecimal number you need converted to an integer: ")
    converted=(int(convertMe,16))
    print(exitMessage)
    print(converted)

#3 for integer to binary
elif whatDoyouwant==3:
    convertMe=int(input("Please provide the integer you need converted to binary: "))
    converted=(bin(convertMe))
    print(exitMessage)
    print(converted)

#4 for binary to integer
elif whatDoyouwant==4:
    convertMe=input("Please provide the binary number you need converted to integers: ")
    converted=(int(convertMe,2))
    print(exitMessage)
    print(converted)

#5 integer to octal
elif whatDoyouwant==5:
    convertMe=int(input("Please provide the integer number you need converted to octal: "))
    converted=(oct(convertMe))
    print(exitMessage)
    print(converted)

#6 for octal to integer
elif whatDoyouwant==6:
    convertMe=input("Please provide the octal number you need converted to integers: ")
    converted=(int(convertMe,8))
    print(exitMessage)
    print(converted)

#Handle all other numerical inputs not expected
else:
    print ("I can't do that!")
