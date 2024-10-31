extends Area2D

var kill:bool=true


func _on_body_entered(body: Node2D) -> void:
	if(!kill):
		kill=true
		body.death()


func _on_body_exited(_body: Node2D) -> void:
	pass

func _on_timer_timeout() -> void:
	kill=false
