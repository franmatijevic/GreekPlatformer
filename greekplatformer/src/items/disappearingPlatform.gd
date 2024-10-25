extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var collisionShape2d: CollisionShape2D = $CollisionShape2D
var isOnPlatform: bool = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if body.is_on_floor():
			isOnPlatform = true
			timer.wait_time = 1
			timer.start()
			
func _on_area_2d_body_exited(body):
	isOnPlatform = false
	timer.wait_time = 3
	timer.start()

func _on_timer_timeout():
	var tween = create_tween()
	
	if isOnPlatform == true:
		tween.tween_property(self, "modulate:a", 0, 0.4)
		collisionShape2d.disabled = true
		isOnPlatform = false
	else:
		tween.tween_property(self, "modulate:a", 1, 0.4)
		collisionShape2d.disabled = false
