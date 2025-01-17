extends State

var time:float=3

const head = preload("res://src/player/playerDeathBodyParts/head.tscn")
const torso= preload("res://src/player/playerDeathBodyParts/torso.tscn")
const bedro=preload("res://src/player/playerDeathBodyParts/bedro.tscn")
const list=preload("res://src/player/playerDeathBodyParts/list.tscn")
const stopalo=preload("res://src/player/playerDeathBodyParts/stopalo.tscn")
const nadlaktica=preload("res://src/player/playerDeathBodyParts/nadlaktica.tscn")
const podlaktica=preload("res://src/player/playerDeathBodyParts/podlaktica.tscn")

@onready var body=player().get_node("ProceduralAnimation/CharacterContainer/Body")

var room

func enter():
	player().dead=true
	player().visible=false
	room=player().get_parent().current_room
	AudioController.stop_door_opening()
	AudioController.play_death()
	bodyPart(head, "Glava")
	bodyPart(torso, "Torso")
	bodyPart(bedro, "LijevoBedro")
	bodyPart(bedro, "DesnoBedro")
	bodyPart(list, "LijeviList")
	bodyPart(list, "DesniList")
	bodyPart(stopalo, "LijevoStopalo")
	bodyPart(stopalo, "DesnoStopalo")
	bodyPart(nadlaktica,"LijevaNadlaktica")
	bodyPart(nadlaktica, "DesnaNadlaktica")
	bodyPart(podlaktica,"LijevaPodlaktica")
	bodyPart(podlaktica, "DesnaPodlaktica")
	
	player().get_parent().get_node("Camera").set_state("Death")
	
	time=1
	
	var black = player().get_parent().get_node("BlackScreen/Control")
	var tween = create_tween()
	tween.tween_interval(0.6)
	tween.tween_property(black, "modulate:a", 0.3, 0.4)
	
	
	if(player().holding_object):
		player().throw( Vector2(player().velocity.x, -10) )
	
	player().direction=0
	player().velocity=Vector2.ZERO

func bodyPart(bodyPart, target):
	var part = bodyPart.instantiate()
	room.call_deferred("add_child", part)
	
	if(!player().impactPoint):
		part.linear_velocity=(body.get_node(target).global_position-player().global_position).normalized()*player().velocity.length()
		
		part.linear_velocity*=0.4
	else:
		var value=player().velocity.length()#*0.4
		if(player().impactValue):
			value=player().impactValue
		
		part.linear_velocity=(body.get_node(target).global_position-player().impactPoint).normalized()*value
		
	
	part.set_deferred("global_position",body.get_node(target).global_position)
	part.set_deferred("rotation", body.get_node(target).rotation)

func update_physics_process(delta:float):
	player().velocity=Vector2.ZERO
	
	if time>0:
		time-=delta
	else:
		player().get_parent().restart()

func exit():
	player().dead=false
	player().visible=false
	player().impactPoint=null
	player().impactValue=null
