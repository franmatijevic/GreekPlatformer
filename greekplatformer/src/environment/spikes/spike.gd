extends Area2D

func _on_body_entered(body: Node2D) -> void:
	set_collision_mask_value(1,false)
	body.death()
