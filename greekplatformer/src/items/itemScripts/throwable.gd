extends RigidBody2D

class_name Throwable

var pickedUp:bool = false
var throwForce:Vector2

@export var picking_up_time:float=0.2

var player = null#get_node("../Player")


func _physics_process(_delta):
	if pickedUp:
		self.global_position = player.get_node("Marker2D").global_position

func be_picked_up(charact:Character):
	pickedUp = true
	player = charact
	freeze=true

func be_thrown(force:Vector2):
	set_deferred("freeze", false)
	#freeze=false
	pickedUp = false
	linear_velocity = force
