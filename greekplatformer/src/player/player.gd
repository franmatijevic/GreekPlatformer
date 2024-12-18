extends Character

class_name Player

@onready var current_state: State = get_node("States/MoveState")
@onready var icon: Sprite2D = $Icon
@onready var marker_2d: Marker2D = $Marker2D
@onready var collision_shape_2d: CollisionShape2D = $DetectPickup/CollisionShape2D

const jumpBufferTime: float = 0.105
const coyoteBufferTime: float = 0.105
const pickUpBufferTime:float =0.105

const throw_force: Vector2 = Vector2(800, -700)

var states: Dictionary = {}
var coyoteBuffer: float = 0
var jumpBuffer: float = 0
var pickUpBuffer:float = 0
var canPickUp: bool = true
var facing_direction: bool = true  # true is right, false is left
var holding_object = null

var dead:bool=false

func _ready():
	for i in get_node("States").get_children():
		states[i.name.to_lower()] = i
	if current_state:
		current_state.enter()


func _physics_process(delta: float) -> void:
	if direction:
		if(!is_on_floor() or velocity.x*$"ProceduralAnimation".k>=0):
			if direction == -1:
				facing_direction = false
				icon.flip_h = true
				marker_2d.position = Vector2(-52, -5)
				#marker_2d.position = Vector2(-24, -4)
				collision_shape_2d.position = Vector2(-63, 25)
				$ProceduralAnimation.flip(true)
			elif direction == 1:
				facing_direction = true
				icon.flip_h = false
				#marker_2d.position = Vector2(18, -4)
				marker_2d.position = Vector2(49,-5)
				collision_shape_2d.position = Vector2(14, 25)
				$ProceduralAnimation.flip(false)
	

	if coyoteBuffer > 0:
		coyoteBuffer -= delta
	
	if pickUpBuffer>0:
		pickUpBuffer -= delta
	
	if jumpBuffer > 0:
		if is_on_floor():
			jump()
		jumpBuffer -= delta

	if current_state:
		current_state.update_physics_process(delta)
	super(delta)

func _process(delta: float) -> void:
	if current_state:
		current_state.update_process(delta)

func pick_up():
	if holding_object != null:
		return
	
	
	var bodies = get_node("DetectPickup").get_overlapping_bodies()
	if bodies.size() == 0:
		pickUpBuffer=pickUpBufferTime
		return

	var closest_object = bodies[0]

	for i in bodies:
		if global_position.distance_to(closest_object.global_position) > global_position.distance_to(i.global_position):
			closest_object = i
	
	holding_object = closest_object
	if(closest_object is Throwable):
		set_state("PickUpState")
	else:
		set_state("InteractState")

func throw(throwing_force: Vector2):
	if holding_object == null:
		return

	var force: Vector2 = throwing_force

	if !facing_direction:
		force.x = -force.x
	
	get_node("ProceduralAnimation").set_arms("Throw")
	
	holding_object.be_thrown(force)
	holding_object = null
	
	

func pick_or_throw():
	if holding_object == null:
		pick_up()
	else:
		throw(throw_force)


func jump():
	if holding_object:
		return

	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		coyoteBuffer = 0
		jumpBuffer = 0
		jumped = true
	elif coyoteBuffer > 0 and jumped == false:
		velocity.y = JUMP_VELOCITY
		coyoteBuffer = 0
		jumpBuffer = 0
		jumped = true
	else:
		jumpBuffer = jumpBufferTime

func stop_jump():
	if velocity.y < 0 and jumped == true:
		velocity.y = 0

func restart():
	velocity = Vector2.ZERO
	get_node("ProceduralAnimation").restart()

func shoot():
	if holding_object:
		return
	set_state("ShootingState")

func death():
	if(current_state.name!="DeadState"):
		set_state("DeadState")

func set_state(state: String):
	current_state.exit()
	current_state = states[state.to_lower()]
	current_state.enter()

func _on_detect_floor_body_entered(_body: Node2D) -> void:
	jumped = false

func _on_detect_floor_body_exited(_body: Node2D) -> void:
	coyoteBuffer = coyoteBufferTime


func _on_detect_pickup_body_entered(_body: Node2D) -> void:
	if(pickUpBuffer>0):
		pick_up()
