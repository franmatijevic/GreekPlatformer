extends RigidBody2D

var pickedUp:bool = false
var throwForce:Vector2
@onready var player = get_node("../Player")

func _physics_process(delta):
	if pickedUp:
		self.position = player.get_node("Marker2D").global_position


func _input(event):
	if Input.is_action_just_pressed("pick_up_item"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and player.canPickUp == true:
				pickedUp = true
				player.canPickUp = false

	if Input.is_action_just_pressed("drop_item"):
		linear_velocity = Vector2(0, -10)
		pickedUp = false
		player.canPickUp = true
	
	if Input.is_action_just_pressed("throw_item"):
		pickedUp = false
		player.canPickUp = true
		linear_velocity = throwForce

		
