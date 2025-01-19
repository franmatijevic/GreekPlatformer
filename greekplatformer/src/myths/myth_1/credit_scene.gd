extends Node2D

@export var duration:float=10


func _ready() -> void:
	var t  = create_tween()
	t.set_parallel(false)
	t.tween_interval(1)
	t.tween_property(get_node("Control"), "modulate:a", 0, 3)
	t.tween_interval(duration)
	t.tween_property(get_node("Control"), "modulate:a", 1, 3)
	t.tween_interval(1)
	t.tween_callback(end_credits)

func _physics_process(delta: float) -> void:
	
	get_node("Text").global_position.y+=delta*100

func end_credits():
	SceneLoader.load_more_level("res://src/ui/main_menu.tscn")
