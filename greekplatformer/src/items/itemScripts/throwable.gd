extends RigidBody2D

class_name Throwable

var pickedUp:bool = false
var throwForce:Vector2

var thrownSound = false

@export var picking_up_time:float=0.2

var player = null#get_node("../Player")

@export var offset:Vector2=Vector2.ZERO#kako ce player drzati predmet u rukama

@export var sound:AudioStreamPlayer2D

func _physics_process(delta):
	if linear_velocity.y == 0:
		linear_velocity.x = 0
	
	if pickedUp:
		global_position = global_position.move_toward(player.get_node("ProceduralAnimation").holdingObjectPoint.global_position + offset, delta*99999)
	elif thrownSound == true and self.linear_velocity == Vector2.ZERO:
		#AudioController.play_stone_fall()
		AudioController.positionSound(sound, 1)
		thrownSound = false
	elif linear_velocity!=Vector2.ZERO:
		thrownSound=true
	#elif linear_velocity.x!=0:
	#	thrownSound=true
	#elif abs(linear_velocity.y)>500:
	#	thrownSound=true

func be_picked_up(charact:Character):
	pickedUp = true
	player = charact
	freeze=true

func be_thrown(force:Vector2):
	set_deferred("freeze", false)
	thrownSound = true
	#freeze=false
	pickedUp = false
	linear_velocity = force
