extends Sprite2D

@export var speed:float = 100

@export_range(0.2, 1) var distance:float=1

@export var randomDistance:bool=true

func _ready() -> void:
	randomize()
	
	if randomDistance:
		distance = randf_range(0.2,1)
	
	scale *=distance
	speed = 100 * (0.5 + distance)

func _process(delta: float) -> void:
	global_position.x += speed*delta
