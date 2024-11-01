extends StaticBody2D

@export var connectedTo:Array[Node2D] = []

var count:int=0
var plate_speed:float=5
var time=-99

func _physics_process(delta: float) -> void:
	if(count>0):
		time=0.3
		$Plate.position.y = move_toward($Plate.position.y, 10, plate_speed)
	else:
		if(time>0):
			time-=delta
			$Plate.position.y = move_toward($Plate.position.y, 10, plate_speed)
		else:
			if(time>-3):
				do_action(false)
				time=-99
			$Plate.position.y = move_toward($Plate.position.y, 0, plate_speed)

func do_action(togle:bool):
	for i in connectedTo:
		i.action(togle)

func _on_detect_something_body_entered(_body: Node2D) -> void:
	count=count+1
	if(count==1 and time==-99):
		do_action(true)

func _on_detect_something_body_exited(_body: Node2D) -> void:
	count=count-1
