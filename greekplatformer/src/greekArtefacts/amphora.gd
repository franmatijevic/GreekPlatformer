extends Node2D

@onready var intercated: Label = $Intercated
@onready var interact: Label = $Interact

var object_reached = false
var object_interacted = false

func _process(delta: float) -> void:
	if (object_reached && Input.is_action_pressed("pickThrow")):
		intercated.visible = true
		interact.visible = false
	elif (object_reached):
		intercated.visible = false
		interact.visible = true
	else:
		intercated.visible = false
		interact.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		object_reached = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		object_reached = false
