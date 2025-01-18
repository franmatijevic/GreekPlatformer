extends Area2D

@export var offset:float=0

func _on_body_entered(body: Node2D) -> void:
	var t = create_tween()
	t.tween_property(body, "cameraOffset", offset, 1)
	#body.cameraOffset = offset

func _on_body_exited(body: Node2D) -> void:
	#body.cameraOffset=0
	var t = create_tween()
	t.tween_property(body, "cameraOffset", 0, 1)
