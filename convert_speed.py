#!/usr/bin/python3

distance=int(input("Please specify the distance in KM that you traveled: "))

time=int(input("Please specify the time in hours traveled: " ))

print("")
print("Your speed in kpm is: ", distance/time)
print("")
print("Your speed in mph is: ", (distance/1.6)/time)
print("")
print("Your speed in Meters per second is: ", (distance*1000)/time)
print("")
