extends StaticBody2D

func _on_detect_body_entered(body: Node2D) -> void:
	if body.name == "Player":
			$AnimationPlayer.play("broken")
			$CPUParticles2D.emitting = true
			await $AnimationPlayer.animation_finished
			AudioController.play_breaking_platform()
			queue_free()
	else:
			$AnimationPlayer.play("idle")
