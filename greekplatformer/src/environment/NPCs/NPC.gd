extends Sprite2D

@export var entryPosition: Vector2
@export var exitPosition: Vector2
@export var speed: float = 100
@export var currentKey = ""

var moving = false
var fading = false
var targetPosition = Vector2()
var fade_target_alpha
var fade_duration
var fade_timer = 0.0

func _ready():
	SignalBus.connect("npc_enter", Callable(self, "_on_npc_enter"))
	SignalBus.connect("npc_exit", Callable(self, "_on_npc_exit"))
	SignalBus.connect("perform_action", Callable(self, "_on_perform_action"))
	position = entryPosition
	
func _process(delta):
	if (moving):
		move_toward_position(delta)
	if fading:
		update_fade(delta)

func move_toward_position(delta):
	var direction = (targetPosition - position).normalized()
	var distance = speed * delta
	if position.distance_to(targetPosition) > distance:
		get_parent().setCamShake(0.25)
		position += direction * distance
	else:
		position = targetPosition
		moving = false

func _on_npc_enter():
	targetPosition = entryPosition
	moving = true

func _on_npc_exit():
	targetPosition = exitPosition
	moving = true

func update_fade(delta):
	fade_timer += delta
	var progress = clamp(fade_timer / fade_duration, 0, 1)
	var new_alpha = lerp(modulate.a, fade_target_alpha, progress)
	modulate.a = new_alpha
	
	if progress >= 1.0:
		fading = false

func _on_perform_action(action: String, params: Dictionary, key: String):
	if currentKey == key:
		if action == "move_to" and params.has("targetPosition"):
			targetPosition = Vector2(params["targetPosition"][0], params["targetPosition"][1])
			moving = true
		elif action == "fade" and params.has("targetAlpha") and params.has("duration"):
			fade_target_alpha = params["targetAlpha"]
			fade_duration = params["duration"]
			fade_timer = 0.0
			fading = true
		elif action == "exit":
			_on_npc_exit()
