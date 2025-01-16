extends StaticBody2D

class_name Interactable

@export var one_shot:bool=false
@export var use_time:float=0.5
@export var connectedTo:Array[Node] = []

var activating:bool=false
var other_direction:bool=false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if(activating):
		$Handle.rotation_degrees+=90.0/use_time * delta
		if($Handle.rotation_degrees>45):
			$Handle.rotation_degrees = 45
			if(!one_shot):
				other_direction=true
			AudioController.play_lever()
			do_action(true)
			set_physics_process(false)
	else:
		$Handle.rotation_degrees-=90.0/use_time * delta
		if($Handle.rotation_degrees<-45):
			$Handle.rotation_degrees = -45
			if(!one_shot):
				other_direction=false
			do_action(false)
			set_physics_process(false)

func holding_point():
	return get_node("Handle/Point").global_position

func player_interaction():
	if(one_shot and other_direction):
		return
	activating=!other_direction
	set_physics_process(true)

func stop_player_interaction():
	activating=!activating

func do_action(togle:bool):
	for i in connectedTo:
		i.action(togle)
