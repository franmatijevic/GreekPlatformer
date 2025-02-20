extends Node2D

const GAME_SAVE : String = "user://GameSave.json"

@export var duration:float=10

@export var allBlackEffect:float = 3

@export var nextScene:String

@export var textSpeed = 140

@export var useFormalLoading:bool=false

@export var skippable:bool=false
@onready var label_credits_1: Label = $Text/LabelCredits1
@onready var label_credits_2: Label = $Text/LabelCredits2

var artefactCounter : int

var t

func _ready() -> void:
	get_artefact_count()
	if (get_tree().current_scene.name == "CreditScene"):
		label_credits_1.text = "Thank you for playing!
		
		"
		label_credits_2.text = "Artefacts found:
			" + str(artefactCounter) + "/9
			
			"
	
	AudioController.stop_walk()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	for i in get_children():
		if i is AudioStreamPlayer:
			i.play()
	
	#var 
	t  = create_tween()
	t.set_parallel(false)
	t.tween_interval(1)
	t.tween_property(get_node("Control"), "modulate:a", 0, allBlackEffect)
	t.tween_interval(duration)
	t.tween_property(get_node("Control"), "modulate:a", 1, 3)#allBlackEffect)
	t.tween_interval(1)
	t.tween_callback(end_credits)

func _physics_process(delta: float) -> void:
	
	AudioController.stop_walk()
	
	get_node("Text").global_position.y+=delta*textSpeed


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("space") or Input.is_action_just_pressed("pickThrow")) and skippable==true:
		skippable = false
		t.kill()
		t = create_tween().set_parallel(false)
		t.tween_property(get_node("Text"), "modulate:a", 0, 1)
		t.tween_interval(0.7)
		t.tween_callback(end_credits)

func end_credits():
	if useFormalLoading:
		SceneLoader.load_scene(nextScene)
	else:
		SceneLoader.load_more_level(nextScene)

func get_artefact_count():
	if (FileAccess.file_exists(GAME_SAVE)):
		var file = FileAccess.open(GAME_SAVE, FileAccess.READ)
		var json = file.get_as_text()
		var saved_data = JSON.parse_string(json)
		
		artefactCounter = saved_data["artefact_counter"]
		file.close()
