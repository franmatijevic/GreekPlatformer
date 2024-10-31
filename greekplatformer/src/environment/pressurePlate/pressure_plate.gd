extends StaticBody2D


var count:int=0
var plate_speed:float=5
var time=0

func _physics_process(delta: float) -> void:
	if(count>0):
		time=0.3
		$Plate.position.y = move_toward($Plate.position.y, 10, plate_speed)
	else:
		if(time>0):
			time-=delta
			$Plate.position.y = move_toward($Plate.position.y, 10, plate_speed)
		else:
			$Plate.position.y = move_toward($Plate.position.y, 0, plate_speed)

func _on_detect_something_body_entered(_body: Node2D) -> void:
	if(count==0):
		pass
	
	count=count+1

func _on_detect_something_body_exited(_body: Node2D) -> void:
	count=count-1
	if(count==0):
		pass
