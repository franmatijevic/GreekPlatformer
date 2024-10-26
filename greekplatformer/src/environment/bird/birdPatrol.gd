extends StaticBody2D

class_name Bird

@onready var pathFollow = $".."

@export var speed: float = 0.5

var currentVelocity: float
var previous_position: Vector2
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	currentVelocity = speed * delta
	pathFollow.progress_ratio += currentVelocity
	if pathFollow.progress_ratio == 1:
		pathFollow.progress_ratio = 0
	
	velocity = (pathFollow.global_position - previous_position) * 1.2 / delta #dobij brzinu platforme pomocu trenutne i prethodne pozicije
	previous_position = pathFollow.global_position
	
