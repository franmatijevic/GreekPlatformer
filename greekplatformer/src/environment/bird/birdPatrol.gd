extends AnimatableBody2D

class_name Bird

@onready var pathFollow = $".."

@export var speed: float = 0.5

var previous_position: Vector2
 
func _physics_process(delta):
	previous_position = pathFollow.global_position
	
	pathFollow.progress_ratio += speed * delta
	if pathFollow.progress_ratio == 1:
		pathFollow.progress_ratio = 0
	
	
	get_node("BirdSprite").rotation= previous_position.angle_to_point(global_position) 
	
