extends StaticBody2D


@onready var timer: Timer = $Timer
@onready var collision_shape_2d = $CollisionShape2D
var timeOnPlatform = randf() + 0.2
var reaperTime = randi() % 5 + 5
var isOnPlatform: bool = false
var disappear: bool = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.is_on_floor():
			isOnPlatform = true
			timer.wait_time = timeOnPlatform
			timer.start()
			
func _on_area_2d_body_exited(_body):
	if collision_shape_2d.disabled() == false && isOnPlatform == true:
		isOnPlatform = false
		disappear = true
	
func _on_timer_timeout():
	var tween = create_tween()
	if isOnPlatform == true or (isOnPlatform == false and disappear == true):
		disappear = false
		tween.tween_property(self, "modulate:a", 0, 0.4)
		collision_shape_2d.set_deferred("disabled", true)
		isOnPlatform = false;
		timer.wait_time = reaperTime
		timer.start()
	else:
		tween.tween_property(self, "modulate:a", 1, 0.4)
		collision_shape_2d.set_deferred("disabled", false)
		
		
		
	
