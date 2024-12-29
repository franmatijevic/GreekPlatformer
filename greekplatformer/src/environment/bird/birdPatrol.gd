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
	
	
	if global_position.x < previous_position.x:
		get_node("BirdSprite").scale.x = -abs(get_node("BirdSprite").scale.x)
	else:
		get_node("BirdSprite").scale.x = abs(get_node("BirdSprite").scale.x)

	
