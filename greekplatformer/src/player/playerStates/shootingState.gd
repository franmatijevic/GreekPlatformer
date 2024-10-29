extends State

#const arrow: PackedScene = preload("res://src/mainMechanics/arrow.tscn")

const rotation_speed:float=2
const highest_angle:float=PI/3
const lowest_angle:float=-PI/3

@onready var icon = get_parent().get_parent().get_node("ArrowIcon")

var angle:float=highest_angle

var clockwise:bool=true#direction of rotation
var hold_shoot:bool=false#ako drzis shoot gumb

var facing:bool=true

func enter():
	hold_shoot=false
	icon.visible=true
	clockwise=false
	angle=lowest_angle
	
	if(player().facing_direction): facing=true
	else: facing=false

func exit():
	icon.visible=false

func update_process(_delta:float):
	if(facing):
		icon.rotation=angle
	else:
		icon.rotation=PI - angle

func update_physics_process(delta:float):
	if(!hold_shoot):
		if(clockwise):
			angle+=rotation_speed*delta
			if(angle>highest_angle): 
				clockwise=!clockwise
		else:
			angle-=rotation_speed*delta
			if(angle<lowest_angle): 
				clockwise=!clockwise
	
	
	if Input.is_action_just_pressed("shoot"):
		hold_shoot=true
	elif Input.is_action_just_released("shoot"):
		shoot()

func shoot():
	var arrow:Arrow
	
	if(facing): arrow = Arrow.new_arrow(angle)
	else: arrow = Arrow.new_arrow(PI - angle)
	
	arrow.global_position=icon.global_position
	player().get_parent().current_room.get_node("Objects").add_child(arrow)
	player().set_state("MoveState")
