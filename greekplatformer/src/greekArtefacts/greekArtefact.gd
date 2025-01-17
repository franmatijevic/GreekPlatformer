extends Node2D

@onready var intercated: Label = $Intercated
@onready var interact: Label = $Interact
@onready var artefact_information: CanvasLayer = $ArtefactInformation

var object_reached = false

func _process(delta: float) -> void:
	if (object_reached && Input.is_action_pressed("pickThrow")):
		interact.visible = false
		artefact_information.visible = true
		SignalBus.emit_on_interacted_artefact()
	
	elif (artefact_information.visible == true && Input.is_action_pressed("pause")):
		artefact_information.visible = false
		
	elif (object_reached):
		interact.visible = true
	else:
		interact.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		object_reached = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		object_reached = false
