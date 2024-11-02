extends CanvasLayer

@export_file("*json") var sceneTextFile: String

var sceneText = {}
var selectedText = []
var inProgress = false

@onready var background = $Background
@onready var textLabel = $TextLabel

func _ready():
	background.visible = false
	sceneText = load_scene_text()
	SignalBus.connect("display_dialogue", Callable(self, "on_display_dialogue"))

func load_scene_text():
	if FileAccess.file_exists(sceneTextFile):
		var file = FileAccess.open(sceneTextFile, FileAccess.READ)
		var testJSONConv = JSON.new()
		testJSONConv.parse(file.get_as_text())
		return testJSONConv.get_data()

func show_text():
	textLabel.text = selectedText.pop_front()

func next_line():
	if selectedText.size() > 0:
		show_text()
	else:
		finish()

func finish():
	textLabel.text = ""
	background.visible = false
	inProgress = false
	get_tree().paused = false
	SignalBus.emit_signal("dialogue_finished")

func on_display_dialogue(textKey):
	if inProgress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		inProgress = true
		selectedText = sceneText[textKey].duplicate()
		show_text()
