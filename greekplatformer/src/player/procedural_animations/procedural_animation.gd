extends Node2D


@onready var leftFoot = $"IK Targets/LeftFoot"
@onready var rightFoot = $"IK Targets/RightFoot"
@onready var leftArm = $"IK Targets/LeftArm"
@onready var rightArm = $"IK Targets/RightArm"
@onready var head = $"IK Targets/Head"

@onready var targetLeftLeg = $"StepTargets/leftFoot"
@onready var targetRightLeg = $"StepTargets/rightFoot"
@onready var targetLeftArm = $"StepTargets/leftArm"
@onready var targetRightArm = $"StepTargets/rightArm"

@onready var hip = $"CharacterContainer/Bones/Skeleton2D/Hip"

@onready var shoulder = $"CharacterContainer/Bones/Skeleton2D/Hip/LeftArm"

@onready var holdingObjectPoint = $"CharacterContainer/Bones/Skeleton2D/Hip/LeftArm/UpperArm/LowerArm/Marker2D"

var armStates: Dictionary = {}
var legStates: Dictionary = {}
var hipState:Dictionary = {}

@export var legs_state:State
@export var arms_state:State
@export var hip_state:State

var legSpeed=100
var armSpeed=100
var hipSpeed=10
var hipAngleSpeed=4


var direction:bool=true
var k=1


const feetOffset:float=20

func _ready():
	
	
	for i in get_node("Leg Machine").get_children():
		legStates[i.name.to_lower()] = i
	
	for i in get_node("Arm Machine").get_children():
		armStates[i.name.to_lower()] = i
	
	for i in get_node("Hip Machine").get_children():
		hipState[i.name.to_lower()] = i
	
	if legs_state:
		legs_state.enter()
	if arms_state:
		arms_state.enter()
	if hipState:
		hip_state.enter()


func _process(delta: float) -> void:
	arms_state.update_process(delta)
	legs_state.update_process(delta)
	hip_state.update_process(delta)

func _physics_process(delta: float) -> void:
	arms_state.update_physics_process(delta)
	legs_state.update_physics_process(delta)
	hip_state.update_physics_process(delta)
	
	
	if(get_parent().velocity.x<0):
		k=-1
	elif(get_parent().velocity.x>0):
		k=1
	
	var normal=-get_parent().get_floor_normal()
	if(!normal):
		normal=Vector2.ZERO
	
	var realTargetLeft=targetLeftLeg.global_position+normal*feetOffset
	var realTargetRight=targetRightLeg.global_position+normal*feetOffset
	
	
	leftFoot.global_position=leftFoot.global_position.move_toward(realTargetLeft, legSpeed*delta)
	rightFoot.global_position=rightFoot.global_position.move_toward(realTargetRight, legSpeed*delta)
	rightArm.global_position=rightArm.global_position.move_toward(targetRightArm.global_position, armSpeed*delta)
	leftArm.global_position=leftArm.global_position.move_toward(targetLeftArm.global_position, armSpeed*delta)

func set_arms(state: String):
	arms_state.exit()
	arms_state = armStates[state.to_lower()]
	arms_state.enter()

func set_legs(state: String):
	legs_state.exit()
	legs_state = legStates[state.to_lower()]
	legs_state.enter()

func set_hip(state: String):
	hip_state.exit()
	hip_state = hipState[state.to_lower()]
	hip_state.enter()

func restart():
	leftFoot.position=Vector2(-1,135)
	rightFoot.position=leftFoot.position
	
	set_arms("IdleState")

func fix_legs():
	leftFoot.global_position = get_node("CharacterContainer/Bones/Skeleton2D/Hip/LeftLeg/LowerLeg/Foot/Marker2D").global_position + feetOffset
	rightFoot.global_position = get_node("CharacterContainer/Bones/Skeleton2D/Hip/RightLeg/LowerLeg/Foot/Marker2D").global_position + feetOffset

func flip(new_dir:bool):
	if(new_dir==direction):
		return
	else:
		direction=new_dir
		
		if(direction==true):
			var stack = get_node("CharacterContainer/Bones/Skeleton2D").modification_stack
			var mod = stack.get_modification(0)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(0))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(180))
			mod = stack.get_modification(1)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(0))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(180))
			mod = stack.get_modification(2)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(0))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(180))
			mod = stack.get_modification(3)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(0))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(180))
			mod = stack.get_modification(4)
			mod.set_constraint_angle_min(deg_to_rad(155))
			mod.set_constraint_angle_max(deg_to_rad(210))
			#mod.set_constraint_angle_invert(false)
			#head.position.x=-abs(head.position.x)
			
		else:
			var stack = get_node("CharacterContainer/Bones/Skeleton2D").modification_stack
			var mod = stack.get_modification(0)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(180))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(360))
			mod = stack.get_modification(1)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(180))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(360))
			mod = stack.get_modification(2)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(180))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(360))
			mod = stack.get_modification(3)
			mod.set_ccdik_joint_constraint_angle_min(1,deg_to_rad(180))
			mod.set_ccdik_joint_constraint_angle_max(1,deg_to_rad(360))
			mod = stack.get_modification(4)
			mod.set_constraint_angle_min(deg_to_rad(25))
			mod.set_constraint_angle_max(deg_to_rad(330))
			mod.set_constraint_angle_invert(true)
			#head.position.x=abs(head.position.x)
		
		
		#var stack = get_node("CharacterContainer/Bones/Skeleton2D").modification_stack
		#stack.enable_all_modifications(false)
		#for i in range(stack.get_modification_count()):
			#var mod = stack.get_modification(i)
			#if mod is SkeletonModification2DCCDIK:
			#	for j in range(mod.get_ccdik_data_chain_length())2:
			#		mod.set_ccdik_joint_constraint_angle_min(j, PI - (mod.get_ccdik_joint_constraint_angle_min(j)))
			#		mod.set_ccdik_joint_constraint_angle_max(j, PI - (mod.get_ccdik_joint_constraint_angle_max(j)))
					
					#mod.set_ccdik_joint_enable_constraint(j,true)
			#elif mod is SkeletonModification2DLookAt:
			#	mod.set_constraint_angle_min(PI-mod.get_constraint_angle_min())
			#	mod.set_constraint_angle_max(PI-mod.get_constraint_angle_max())
				#mod.set_enable_constraint(true)
		
		
		for i in get_node("CharacterContainer/Body").get_children():
			i.set_flip_h(!i.is_flipped_h())
		
		legSpeed=30
		armSpeed=30
		
		rightArm.position=Vector2(0,80)
		leftArm.position=Vector2(0,80)
		
		targetLeftArm.position=Vector2(0,100)
		targetRightArm.position=Vector2(0,100)
		
		#set_legs("AboveGround")
		#leftFoot.position.y=135
		#rightFoot.position.y=135
		
		#leftArm.position.x*=-1
		#rightArm.position.x*=-1
		
		leftFoot.position=Vector2(0,135)
		rightFoot.position=Vector2(0,135)
		targetLeftLeg.position=Vector2(0,150)
		targetRightLeg.position=Vector2(0,150)
		
		
