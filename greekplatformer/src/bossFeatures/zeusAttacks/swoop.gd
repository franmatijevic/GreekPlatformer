extends State

@export var path:PathFollow2D
@export var speed:float

var t=0

func enter():
	t=speed*100
	path.progress_ratio = 0

func _physics_process(delta: float) -> void:
	
	player().global_position = path.global_position
	
	path.progress_ratio += speed * delta
	
	t = t - delta
	if t<=0:
		player().next_attack()
	
	#if path.progress_ratio == 1:
	#	player().next_attack()

func exit():
	path.progress_ratio = 0
	t=speed*100
