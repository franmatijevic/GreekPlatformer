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

var jumped: bool = false
var direction # only horizontal

var currentPlatform: Node2D = null

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		if velocity.y > 0:
			velocity.y += falling_gravity * delta
		else:
			velocity.y += gravity * delta

	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DEACCELERATION * delta)
	
	move_and_slide()
	
	if is_on_floor():
		if get_last_slide_collision():
			var collider = get_last_slide_collision().get_collider()
			if collider is Bird:
				currentPlatform = collider
				velocity = collider.velocity
				collider.shape_owner_set_one_way_collision(0, false)
				print("Standing on bird!")
			else:
				if currentPlatform:
					currentPlatform.shape_owner_set_one_way_collision(0, true)
					currentPlatform = null
