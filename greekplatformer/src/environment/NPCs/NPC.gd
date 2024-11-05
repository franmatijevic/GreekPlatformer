extends Sprite2D

@export var entryPosition: Vector2
@export var exitPosition: Vector2
@export var speed: float = 100

var moving = false
var targetPosition = Vector2()

func _ready():
	SignalBus.connect("npc_enter", Callable(self, "_on_npc_enter"))
	SignalBus.connect("npc_exit", Callable(self, "_on_npc_exit"))
	SignalBus.connect("perform_action", Callable(self, "_on_perform_action"))
	position = entryPosition
	
func _process(delta):
	if(moving):
		move_toward_position(delta)

func move_toward_position(delta):
	var direction = (targetPosition - position).normalized()
	var distance = speed * delta
	if position.distance_to(targetPosition) > distance:
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

func _on_perform_action(action: String, params: Dictionary):
	if action == "move_to" and params.has("targetPosition"):
		targetPosition = Vector2(params["targetPosition"][0], params["targetPosition"][1])
		moving = true
	elif action == "exit":
		_on_npc_exit()
