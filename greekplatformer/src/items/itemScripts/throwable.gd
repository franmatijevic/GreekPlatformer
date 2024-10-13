extends RigidBody2D

var pickedUp:bool = false
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
		pickedUp = false
		player.canPickUp = true
		if player.get_node("Icon").flip_h == false:
			apply_impulse(Vector2(), Vector2(90, -10))
		else:
			apply_impulse(Vector2(), Vector2(-90, -10))

		
