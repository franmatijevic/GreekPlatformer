extends RigidBody2D

class_name Throwable

var pickedUp:bool = false
var throwForce:Vector2

@export var picking_up_time:float=0.2

var player = null#get_node("../Player")

@export var offset:Vector2=Vector2.ZERO#kako ce player drzati predmet u rukama


func _physics_process(delta):
	if pickedUp:
		global_position = global_position.move_toward(player.get_node("ProceduralAnimation").holdingObjectPoint.global_position + offset, delta*99999)


func be_picked_up(charact:Character):
	pickedUp = true
	player = charact
	freeze=true

func be_thrown(force:Vector2):
	set_deferred("freeze", false)
	#freeze=false
	pickedUp = false
	linear_velocity = force
