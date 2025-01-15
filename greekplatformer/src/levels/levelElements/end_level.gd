extends Area2D

@export var nextLevelPath:String

func _on_body_entered(body: Node2D) -> void:
	var t=create_tween()
	t.tween_interval(0.1)
	SceneLoader.load_scene(nextLevelPath)
