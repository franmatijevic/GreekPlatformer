extends RigidBody2D

class_name Throwable

var pickedUp:bool = false
var throwForce:Vector2

@export var picking_up_time:float=0.2
@export var playerCanJump:bool=false

var player = null#get_node("../Player")

func _physics_process(_delta):
	if pickedUp:
		self.position = player.get_node("Marker2D").global_position

func be_picked_up(charact:Character):
	pickedUp = true
	player = charact

func be_thrown(force:Vector2):
	pickedUp = false
	linear_velocity = force

#func _input(_event):
	#if Input.is_action_just_pressed("pick_up_item") and 1==0:
		#var bodies = $Area2D.get_overlapping_bodies()
		#for body in bodies:
			#if body.name == "Player" and player.canPickUp == true:
				#pickedUp = true
				#player.canPickUp = false
#
	#if Input.is_action_just_pressed("drop_item") and pickedUp == true and 1==0:
		#linear_velocity = Vector2(0, -10)
		#pickedUp = false
		#player.canPickUp = true
	#
	#if Input.is_action_just_pressed("throw_item") and pickedUp == true and 1 == 0:
		#pickedUp = false
		#player.canPickUp = true
		#linear_velocity = throwForce
