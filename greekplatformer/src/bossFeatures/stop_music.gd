extends Area2D

func _on_body_entered(body: Node2D) -> void:
	AudioController.boss_music_fade()
	call_deferred("queue_free")
