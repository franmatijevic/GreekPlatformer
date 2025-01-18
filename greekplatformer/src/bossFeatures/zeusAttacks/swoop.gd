extends State

@export var path:PathFollow2D
@export var speed:float

@export var reversedDirection:bool=false

func enter():
	if !reversedDirection:
		path.progress_ratio = 0
	else:
		path.progress_ratio=1

func update_physics_process(delta: float) -> void:
	
	player().rotateToFacing()
	
	
	player().global_position = path.global_position
	
	if !reversedDirection:
		path.progress_ratio += speed * delta
		if path.progress_ratio == 1:
			player().next_attack()
	else:
		path.progress_ratio -= speed * delta
		if path.progress_ratio == 0:
			player().next_attack()

func exit():
	path.progress_ratio = 0
