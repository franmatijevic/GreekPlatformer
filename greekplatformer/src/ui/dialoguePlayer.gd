extends Node2D

@export_file("*json") var sceneTextFile: String
@export var speechBubbleScene: PackedScene
@onready var speechBubbleLayer: CanvasLayer = $"../DialogueLayer"

var sceneText = {}
var selectedText = []
var inProgress = false
var activeSpeaker = ""
var speechBubbles = {}
var speakerMarkers = {}
var audioMarkers = {}
var currentKey

var displayFullText:bool = false
var textSpeed = 0.05
var tween

signal npc_enter
signal npc_exit
signal perform_action(action: String, params: Dictionary, key: String)

func _ready():
	sceneText = load_scene_text()
	SignalBus.connect("display_dialogue", Callable(self, "on_display_dialogue"))
	SignalBus.connect("display_full_text", Callable(self, "_display_full_text"))
	
	speakerMarkers["Zeus"] = $"../Zeus/ZeusDialogueMarker"
	speakerMarkers["Prometej"] = $"../Player/PlayerDialogueMarker"
	speakerMarkers["Atena"] = $"../Atena/AtenaDialogueMarker"
	speakerMarkers["Atena2"] = $"../Atena2/Atena2DialogueMarker"

func load_scene_text():
	if FileAccess.file_exists(sceneTextFile):
		var file = FileAccess.open(sceneTextFile, FileAccess.READ)
		var testJSONConv = JSON.new()
		testJSONConv.parse(file.get_as_text())
		return testJSONConv.get_data()

func show_text(text) -> void:
	
	AudioController.play_dialogue(activeSpeaker)
	
	for bubble in speechBubbles.values():
		bubble.visible = false
	
	if not speechBubbles.has(activeSpeaker):
		var newBubble = speechBubbleScene.instantiate()
		speechBubbleLayer.add_child(newBubble)
		
		newBubble.get_node("Label").visible_ratio = 0.0
		newBubble.get_node("Label").text = text
		
		if speakerMarkers.has(activeSpeaker):
			newBubble.position = speakerMarkers[activeSpeaker].global_position
		
		speechBubbles[activeSpeaker] = newBubble
		
		tween = create_tween()
		tween.tween_property(newBubble.get_node("Label"), "visible_ratio", 1.0, textSpeed*text.length())
		await get_tree().create_timer(textSpeed*text.length()).timeout
		AudioController.stop_dialogue(activeSpeaker)
		SignalBus.emit_signal("can_click_next")
	else:
		speechBubbles[activeSpeaker].get_node("Label").text = text
		speechBubbles[activeSpeaker].visible = true
		
		speechBubbles[activeSpeaker].get_node("Label").visible_ratio = 0.0
		tween = create_tween()
		tween.tween_property(speechBubbles[activeSpeaker].get_node("Label"), "visible_ratio", 1.0, textSpeed*text.length())
		await get_tree().create_timer(textSpeed*text.length()).timeout
		AudioController.stop_dialogue(activeSpeaker)
		SignalBus.emit_signal("can_click_next")

	
func create_speaker_label(speaker_name):
	var newLabel = Label.new()
	newLabel.text = ""
	newLabel.theme = preload("res://src/dialogue/dialogueArt/speechBubble.png")
	add_child(newLabel)
	
	if speakerMarkers.has(speaker_name):
		newLabel.position = speakerMarkers[speaker_name].position + Vector2(0, -50)
		
	return newLabel
	
func next_line():
	if selectedText.size() > 0:
		var line = selectedText.pop_front()
		handle_line(line)
	else:
		finish()

func handle_line(line):
	activeSpeaker = line["speaker"]
	
	show_text(line["text"])
	
	if line.has("action") and line["action"] != "none":
		var params = {}
		if line.has("parameters"):
			params = line["parameters"]
		SignalBus.emit_signal("perform_action", line["action"], params, currentKey)

func finish():
	for bubble in speechBubbles.values():
		bubble.visible = false
	inProgress = false
	get_parent().get_node("Player").set_state("MoveState")
	SignalBus.emit_signal("dialogue_finished", currentKey)
	SignalBus.emit_signal("npc_exit")
	
func on_display_dialogue(textKey):
	if inProgress:
		next_line()
	else:
		currentKey = textKey
		SignalBus.emit_signal("npc_enter")
		get_parent().get_node("Player").set_state("DialogState")
		inProgress = true
		selectedText = sceneText[textKey].duplicate()
		next_line()

func _display_full_text():
	displayFullText = true
	tween.kill()
	AudioController.stop_dialogue(activeSpeaker)
	speechBubbles[activeSpeaker].get_node("Label").visible_ratio = 1.0
