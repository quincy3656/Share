#!/usr/bin/python3

import random

takeAguess=int(input("SO you think you're physic huh? What number am I going to spit out at you? Need a hint? its between 1 and 1000.  Good luck sucker.  "))

ranNumber=(int(random.randrange(1000)))

if takeAguess == ranNumber:
    print("Your number")
    print(takeAguess)
    print("My number")
    print(ranNumber)
    print("Wow good job, you guessed the same number as me. Now get a life")

#elif takeAguess != ranNumber:
#    print("Your number")
#    print(takeAguess)
#    print("My number")
#    print(ranNumber)
#    print("Well well well, looks like you ain't as good as you think you are nerd. Try again")

elif takeAguess < 0:
    print("Re-read what I told you the range was and try again when you get some glasses")

elif takeAguess > 1000:
    print("Are you blind? re-read what I told you the range was and try again when you get some glasses.")

elif takeAguess > ranNumber:
    print("Your number")
    print(takeAguess)
    print("My number")
    print(ranNumber)
    print("TOO HIGH!")

elif takeAguess < ranNumber:
    print("Your number")
    print(takeAguess)
    print("My number")
    print(ranNumber)
    print("TOO LOW!")
