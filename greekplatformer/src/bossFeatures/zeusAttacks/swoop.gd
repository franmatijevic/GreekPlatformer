extends State

@export var path:PathFollow2D
@export var speed:float


func enter():
	path.progress_ratio = 0

func update_physics_process(delta: float) -> void:
	
	player().global_position = path.global_position
	
	path.progress_ratio += speed * delta
	
	if path.progress_ratio == 1:
		player().next_attack()

func exit():
	path.progress_ratio = 0
