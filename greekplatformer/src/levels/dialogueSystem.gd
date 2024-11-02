extends Area2D

@export var dialogueKey = ""
@export var oneTime = false

var areaActive = false

func _ready():
	SignalBus.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

func _input(event):
	if areaActive and event.is_action_pressed("ui_accept"):
		SignalBus.emit_signal("display_dialogue", dialogueKey)

func _on_area_entered(_area):
	areaActive = true
	if oneTime:
		SignalBus.emit_signal("display_dialogue", dialogueKey)

func _on_area_exited(_area):
	areaActive = false

func _on_dialogue_finished():
	if oneTime:
		queue_free()
