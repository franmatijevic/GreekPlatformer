extends Node

@export var count:int=0##broj potrebnih aktivacija
#npr ako count=3 onda ce trebati povuci 3 levera/gumba da se dalje aktivira

@export var connectedTo:Array[Node] = []

func action(togle:bool):
	if(togle):
		count = count - 1
	else:
		count = count + 1
	if(count==0):
		do_action(true)
	elif(count==1):
		do_action(false)

func do_action(togle:bool):
	for i in connectedTo:
		i.action(togle)
