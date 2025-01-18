extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.death()
	if body is Throwable and body.name=="Torch":
		get_parent().get_parent().get_parent().get_node("Player").death()
