extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Throwable:
		pass
		#body.get_node("CollisionShape2D").set_deferred("disabled", true)
	else:
		body.death()
