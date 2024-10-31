extends Area2D

@export var distance:float=100
@export var speed:float=100

var normal_position:Vector2
var new_position:Vector2

var target:bool=false

func _ready() -> void:
	set_physics_process(false)

func _on_body_entered(body: Node2D) -> void:
	body.death()

func _physics_process(delta: float) -> void:
	if(target):
		if(global_position==new_position):
			
			set_physics_process(false)
		else: 
			global_position = global_position.move_toward(new_position, speed*delta)
	elif(!target):
		if(global_position==normal_position):
			set_physics_process(false)
		else:
			global_position = global_position.move_toward(normal_position, speed*delta)

func action(togle:bool):
	if(togle==true):
		normal_position = global_position
		new_position = global_position + Vector2(sin(rotation), -cos(rotation))*distance
	
	target=togle
	set_physics_process(true)
