extends Node2D

@export var duration:float=10

@export var allBlackEffect:float = 3

@export var nextScene:String

@export var textSpeed = 140

@export var useFormalLoading:bool=false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	for i in get_children():
		if i is AudioStreamPlayer:
			i.play()
	
	var t  = create_tween()
	t.set_parallel(false)
	t.tween_interval(1)
	t.tween_property(get_node("Control"), "modulate:a", 0, allBlackEffect)
	t.tween_interval(duration)
	t.tween_property(get_node("Control"), "modulate:a", 1, 3)#allBlackEffect)
	t.tween_interval(1)
	t.tween_callback(end_credits)

func _physics_process(delta: float) -> void:
	
	get_node("Text").global_position.y+=delta*textSpeed

func end_credits():
	if useFormalLoading:
		SceneLoader.load_scene(nextScene)
	else:
		SceneLoader.load_more_level(nextScene)
