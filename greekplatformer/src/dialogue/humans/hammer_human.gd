extends Node2D

@onready var arm = $"Lik-torso/Nadlaktica"
@onready var lakat = $"Lik-torso/Nadlaktica/Lik-podlaktica2"

@onready var armIdle = $"Lik-torso/Nadlaktica2"

@onready var hip = $"Lik-torso"

@onready var bedro1 = $"Lik-torso/Bedro"
@onready var bedro2 = $"Lik-torso/Bedro2"

var hipTime=0

var t=0

func _process(delta: float) -> void:
	t = t + delta*10
	armIdle.rotation = deg_to_rad(5*sin(t))
	
	arm.rotation = deg_to_rad(-120 + sin(t)*30)
	lakat.rotation = deg_to_rad(142.5 + sin(t)*22.5)
	
	#bedro1.rotation = PI/4 + PI/6 - hip.rotation
	#bedro2.rotation = PI/4 + PI/6 - hip.rotation
