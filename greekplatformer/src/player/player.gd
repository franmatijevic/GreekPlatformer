extends Character

class_name Player

@onready var current_state: State = get_node("States/DialogState")
@onready var icon: Sprite2D = $Icon
@onready var marker_2d: Marker2D = $Marker2D
@onready var collision_shape_2d: CollisionShape2D = $DetectPickup/CollisionShape2D
@onready var trajectory_line: Line2D = $TrajectoryLine

const jumpBufferTime: float = 0.105
const coyoteBufferTime: float = 0.105
const pickUpBufferTime:float =0.105

const throw_force: Vector2 = Vector2(750, -750)

var states: Dictionary = {}
var coyoteBuffer: float = 0
var jumpBuffer: float = 0
var pickUpBuffer:float = 0
var canPickUp: bool = true
var facing_direction: bool = true  # true is right, false is left
var holding_object = null

var dead:bool=false
var impactPoint
var impactValue

const GRAVITY = 980

func _ready():
	for i in get_node("States").get_children():
		states[i.name.to_lower()] = i
	if current_state:
		current_state.enter()
	
	var t=create_tween()
	t.tween_interval(2)
	t.tween_callback(start)

func starting():
	set_state("DialogState")
	var t=create_tween()
	t.tween_interval(0.5)
	t.tween_callback(start)

func start():
	set_state("MoveState")

func _physics_process(delta: float) -> void:
	if direction and !holding_object:
		if(!is_on_floor() or (abs(velocity.x)<100)):
			if direction == -1:
				facing_direction = false
				#icon.flip_h = true
				marker_2d.position = Vector2(-52, -5)
				#marker_2d.position = Vector2(-24, -4)
				collision_shape_2d.position = Vector2(-63, 25)
				$ProceduralAnimation.flip(true)
			elif direction == 1:
				facing_direction = true
				#icon.flip_h = false
				#marker_2d.position = Vector2(18, -4)
				marker_2d.position = Vector2(49,-5)
				collision_shape_2d.position = Vector2(14, 25)
				$ProceduralAnimation.flip(false)
	
	if !(is_on_floor() and abs(velocity.x) > 0):
		AudioController.play_walk_ceramic()

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
		
	update_trajectory_with_mouse()
	
	if holding_object and current_state.name!="InteractState":
		flip_player_to_aim()

func flip_player(direction:bool):
	if direction == false:
		facing_direction = false
		marker_2d.position = Vector2(-52, -5)
		collision_shape_2d.position = Vector2(-63, 25)
		$ProceduralAnimation.flip(true)
	elif direction == true:
		facing_direction = true
		marker_2d.position = Vector2(49,-5)
		collision_shape_2d.position = Vector2(14, 25)
		$ProceduralAnimation.flip(false)

func flip_player_to_aim():
	var mouse_pos = get_global_mouse_position()
	facing_direction = mouse_pos.x > global_position.x
	icon.flip_h = !facing_direction
	
	if facing_direction:
		marker_2d.position = Vector2(49, -5)
		collision_shape_2d.position = Vector2(14, 25)
		$ProceduralAnimation.flip(false)
	else:
		marker_2d.position = Vector2(-52, -5)
		collision_shape_2d.position = Vector2(-63, 25)
		$ProceduralAnimation.flip(true)
	
func update_trajectory_with_mouse():
	if holding_object == null or current_state.name == "InteractState":
		trajectory_line.hide()
		return
	
	trajectory_line.show()
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	trajectory_line.update_trajectory(direction, throw_force.length(), GRAVITY, get_physics_process_delta_time(), 50)

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
	
	get_node("ProceduralAnimation").set_arms("Throw")
	
	var force: Vector2 = (get_global_mouse_position() - global_position).normalized() * throwing_force.length()
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
		AudioController.play_jump()
		velocity.y = JUMP_VELOCITY
		coyoteBuffer = 0
		jumpBuffer = 0
		jumped = true
	elif coyoteBuffer > 0 and jumped == false:
		AudioController.play_jump()
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

func _on_detect_floor_body_entered(body: Node2D) -> void:
	jumped = false
	
	if(body is TileMapLayer):
		var percentage=min(velocity.length(),1000)/1000
		
		$HitGroundParticles.amount=round(25*percentage)+1
		$HitGroundParticles.initial_velocity_max=350*percentage
		
		if(!$HitGroundParticles.emitting):
			$HitGroundParticles.emitting=true
		else:
			$HitGroundParticles.restart()

func _on_detect_floor_body_exited(_body: Node2D) -> void:
	coyoteBuffer = coyoteBufferTime


func _on_detect_pickup_body_entered(_body: Node2D) -> void:
	if(pickUpBuffer>0):
		pick_up()
