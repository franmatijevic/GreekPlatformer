extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	get_parent().current_room.get_node("Respawn").global_position=global_position
	get_parent().respawnLocation=global_position
	queue_free()
