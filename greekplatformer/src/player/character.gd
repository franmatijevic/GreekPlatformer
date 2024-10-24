extends CharacterBody2D

class_name Character

@export var gravity:float=100
@export var falling_gravity:float=150

@export var JUMP_VELOCITY:float = 300
@export var SPEED:float=100
@export var ACCELERATION:float=40
@export var DEACCELERATION:float=70

var jumped:bool=false

var direction#only horizontal

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		if velocity.y>0:
			velocity.y+=falling_gravity*delta
		else:
			velocity.y+=gravity*delta
	
	if direction:
		velocity.x= move_toward(velocity.x, SPEED*direction, ACCELERATION*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DEACCELERATION*delta)
		#velocity.x=0
	move_and_slide()
