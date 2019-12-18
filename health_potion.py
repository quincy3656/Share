#!/usr/bin/python3
#by Quinton brown, followed "The python Bible" on udemy to create this.
#importing random module to create random intigers for our potion health
import random
#base health of player
health=50
#difficulty 1=easy 2=medium 3=hard
#difficulty=1
#difficulty=2
difficulty=3
#Main variable to detrmin how much the health the potion will provide, while dividing
#that by the difficulty, while also keeping the value as an intiger and not a float with
#int()
potionHealth=int(random.randint(25,50) / difficulty)
#New health variable after the potion calculation
health=health+potionHealth
#prints the new health vaue to the screen
print (health)
