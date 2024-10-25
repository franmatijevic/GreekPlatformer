extends StaticBody2D

@export var reapear_time:float = 5#vrijeme ponovnog pojavljanja oblaka
@export var max_time_on_platform:float=0.75 ##Maksimalno vrijeme igraca na platformi

@onready var timer: Timer = $Timer
@onready var collisionShape2d: CollisionShape2D = $CollisionShape2D
var isOnPlatform: bool = false
var disappear: bool = false

func _on_area_2d_body_entered(body):
	get_node("Label").text = ":("
	
	if body.name == "Player":
		if body.is_on_floor():
			isOnPlatform = true
			timer.wait_time = max_time_on_platform
			timer.start()
			
func _on_area_2d_body_exited(_body):
	get_node("Label").text=":)"
	
	if collisionShape2d.disabled == false and isOnPlatform == true:
		isOnPlatform = false
		disappear = true
		timer.timeout

	#timer.wait_time = 5
	#timer.start()

func _on_timer_timeout():
	var tween = create_tween()
	
	if isOnPlatform == true or (isOnPlatform == false and disappear == true):
		disappear = false
		tween.tween_property(self, "modulate:a", 0, 0.4)
		collisionShape2d.disabled = true
		isOnPlatform = false
		
		timer.wait_time = reapear_time #ponovno ponavljanje
		timer.start()
	else:
		tween.tween_property(self, "modulate:a", 1, 0.4)
		collisionShape2d.disabled = false
