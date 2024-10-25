extends StaticBody2D

@onready var pathFollow = $".."

@export var speed: float = 0.5

var currentVelocity: float

func _physics_process(delta):
	currentVelocity = speed * delta
	pathFollow.progress_ratio += currentVelocity
	if pathFollow.progress_ratio == 1:
		pathFollow.progress_ratio = 0
