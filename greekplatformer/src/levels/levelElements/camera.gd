extends Node2D

@export var player:Player
@export var current_state:State

@export var decay : float = 0.8 # Time it takes to reach 0% of trauma
@export var max_offset : Vector2 = Vector2(100, 75) # Max hor/ver shake in pixels
@export var max_roll : float = 0.1 # Maximum rotation in radians (use sparingly)
@export var follow_node : Node2D # Node to follow (assign this to your player)

var trauma : float = 0.0 # Current shake strength
var trauma_power : int = 2 # Trauma exponent. Increase for more extreme shaking


var states: Dictionary = {}

var block:bool=false#blokirat ce pauziranje i resetiranje sobe dok traje tranzicija sobe

func _ready():
	global_position=player.global_position
	$Camera2D.reset_smoothing()
	
	for i in get_node("States").get_children():
		states[i.name.to_lower()] = i
	if current_state:
		current_state.enter()

func _process(delta: float) -> void:
	
	if trauma: # If the camera is currently shaking
			trauma = max(trauma - decay * delta, 0) # Decay the shake strength
			shake()

func _physics_process(delta: float) -> void:
	current_state.update_physics_process(delta)

func add_trauma(amount : float) -> void:
	decay=0.8
	trauma = min(trauma + amount, 1.0)

func set_trauma(amount:float)->void:
	trauma=min(amount, 1.0)

func add_long_trauma(amount:float, newDecayValue:float) ->void:
	decay=newDecayValue
	trauma = min(trauma + amount, 1.0)

func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	$Camera2D.offset.x = max_offset.x * amount * randf_range(-1, 1)
	$Camera2D.offset.y = max_offset.y * amount * randf_range(-1, 1) + player.cameraOffset

func set_state(state: String):
	if(state.to_lower()==current_state.name.to_lower()):
		return
	
	current_state.exit()
	current_state = states[state.to_lower()]
	current_state.enter()
