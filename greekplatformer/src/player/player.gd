extends Character

@onready var current_state:State=get_node("States/MoveState")

const jumpBufferTime:float=0.105
const coyoteBufferTime:float=0.105

var states:Dictionary={ }

var coyoteBuffer:float=0
var jumpBuffer:float=0
var jumped:bool=false

var canPickUp:bool = true

var facing_direction:bool=true #true desno, false lijevo

func _ready():
	for i in get_node("States").get_children():
		states[i.name.to_lower()] = i
	if(current_state):
		current_state.enter()

func _physics_process(delta: float) -> void:
	if(direction):
		if(direction==-1): 
			facing_direction=false
			get_node("../Rock").throwForce = Vector2(-500, -700)
		elif(direction==1):
			facing_direction=true
			get_node("../Rock").throwForce = Vector2(500, -700)
	
	
	if(coyoteBuffer>0):
		coyoteBuffer-=delta
	
	if(jumpBuffer>0):
		if(is_on_floor()):
			jump()
		jumpBuffer-=delta
	
	if(current_state):
		current_state.update_physics_process(delta)
	super(delta)

func _process(delta: float) -> void:
	if(current_state):
		current_state.update_process(delta)

func jump():
	if(is_on_floor()):
		velocity.y = -JUMP_VELOCITY
		coyoteBuffer=0
		jumpBuffer=0
		jumped=true
	elif(coyoteBuffer>0 and jumped==false):
		velocity.y = -JUMP_VELOCITY
		coyoteBuffer=0
		jumpBuffer=0
		jumped=true
	else:
		jumpBuffer=jumpBufferTime

func stop_jump():
	if(velocity.y<0 and jumped==true):
		velocity.y=0

func shoot():
	set_state("ShootingState")

func set_state(state:String):
	current_state.exit()
	current_state=states[state.to_lower()]
	current_state.enter()

func _on_detect_floor_body_entered(_body: Node2D) -> void:
	jumped=false

func _on_detect_floor_body_exited(_body: Node2D) -> void:
	coyoteBuffer=coyoteBufferTime
