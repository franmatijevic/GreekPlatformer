extends Area2D

func _ready():
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("default")

func _on_animated_sprite_2d_animation_finished():
	visible = false
