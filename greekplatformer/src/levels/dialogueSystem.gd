extends Area2D

@export var dialogueKey = ""
@export var oneTime = false

var areaActive = false
var canClickNext = true

func _ready():
	SignalBus.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
	SignalBus.connect("npc_exit", Callable(self, "_on_npc_exit"))
	SignalBus.connect("can_click_next", Callable(self, "_can_click_next"))

func _input(event):
	if areaActive and event.is_action_pressed("ui_accept") and canClickNext:
		canClickNext = false
		SignalBus.emit_signal("display_dialogue", dialogueKey)
	elif areaActive and event.is_action_pressed("ui_accept") and !canClickNext:
		SignalBus.emit_signal("display_full_text")

func _on_area_entered(_area):
	areaActive = true
	if oneTime:
		canClickNext = false
		SignalBus.emit_signal("display_dialogue", dialogueKey)

func _on_area_exited(_area):
	areaActive = false

func _on_dialogue_finished():
	if oneTime:
		queue_free()
		
func _can_click_next():
	canClickNext = true
