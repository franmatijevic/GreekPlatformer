extends Area2D

@export var nextLevelPath:String

func _on_body_entered(body: Node2D) -> void:
	body.set_state("DialogState")
	body.trajectory_line.modulate.a=0
	
	var t=create_tween()
	t.set_parallel(false)
	t.tween_property(get_parent().get_parent().get_parent().get_node("BlackScreen/Control"), "modulate:a", 1, 1)
	t.tween_callback(continueFurther)

func continueFurther():
	SceneLoader.load_scene(nextLevelPath)
