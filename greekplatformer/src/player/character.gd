extends CharacterBody2D

class_name Character

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var falling_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@onready var JUMP_VELOCITY: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@export var SPEED: float = 100
@export var ACCELERATION: float = 40
@export var DEACCELERATION: float = 70

@export var Max_falling_speed:float=2300

var jumped: bool = false
var direction # only horizontal

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		if velocity.y > 0:
			velocity.y += falling_gravity * delta
			if(velocity.y>Max_falling_speed):
				velocity.y=Max_falling_speed
		else:
			velocity.y += gravity * delta

	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DEACCELERATION * delta)
	
	move_and_slide()
	
