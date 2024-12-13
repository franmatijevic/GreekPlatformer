extends Node2D


@onready var leftFoot = $"IK Targets/LeftFoot"
@onready var rightFoot = $"IK Targets/RightFoot"
@onready var leftArm = $"IK Targets/LeftArm"
@onready var rightArm = $"IK Targets/RightArm"
@onready var head = $"IK Targets/Head"

@onready var targetLeftLeg = $"StepTargets/leftFoot"
@onready var targetRightLeg = $"StepTargets/rightFoot"

@onready var hip = $"CharacterContainer/Bones/Skeleton2D/Hip"

@onready var shoulder = $"CharacterContainer/Bones/Skeleton2D/Hip/LeftArm"

var armStates: Dictionary = {}
var legStates: Dictionary = {}

@export var legs_state:State
@export var arms_state:State

var direction:bool=false

var remotes:=[]

var step:float=100

func _ready():
	for i in get_node("Leg Machine").get_children():
		legStates[i.name.to_lower()] = i
	
	for i in get_node("Arm Machine").get_children():
		armStates[i.name.to_lower()] = i
	
	if legs_state:
		legs_state.enter()
	if arms_state:
		arms_state.enter()


func _process(delta: float) -> void:
	arms_state.update_process(delta)
	legs_state.update_process(delta)

func _physics_process(delta: float) -> void:
	arms_state.update_physics_process(delta)
	legs_state.update_physics_process(delta)
	
	var speed=200
	
	var realTargetLeft=targetLeftLeg.global_position+Vector2(0,20)
	var realTargetRight=targetRightLeg.global_position+Vector2(0,20)
	
	leftFoot.global_position=leftFoot.global_position.move_toward(realTargetLeft, speed*delta)
	rightFoot.global_position=rightFoot.global_position.move_toward(realTargetRight, speed*delta)
	
	
	#if(get_parent().is_on_floor()):
	#	var leftPoint=targetLeftLeg.get_node("RayCast2D").get_collision_point()
	#	if(leftPoint):
	#		targetLeftLeg.global_position.y=leftPoint.y
	#	var rightPoint=targetRightLeg.get_node("RayCast2D").get_collision_point()
	#	if(rightPoint):
	#		targetRightLeg.global_position.y=rightPoint.y
	
	#get_node("Label").text=legs_state.name

func set_arms(state: String):
	arms_state.exit()
	arms_state = armStates[state.to_lower()]
	arms_state.enter()

func set_legs(state: String):
	legs_state.exit()
	legs_state = legStates[state.to_lower()]
	legs_state.enter()

func fix_legs():
	leftFoot.global_position = get_node("CharacterContainer/Bones/Skeleton2D/Hip/LeftLeg/LowerLeg/Foot/Marker2D").global_position
	rightFoot.global_position = get_node("CharacterContainer/Bones/Skeleton2D/Hip/RightLeg/LowerLeg/Foot/Marker2D").global_position

func flip(new_dir:bool):
	return
	if(new_dir==direction):
		return
	else:
		if(direction==false):
			print("lijevo")
		else:
			print("desno")
		
		direction=new_dir
		var stack = get_node("CharacterContainer/Bones/Skeleton2D").modification_stack
		stack.enable_all_modifications(false)
		for i in range(stack.get_modification_count()):
			var mod = stack.get_modification(i)
			if mod is SkeletonModification2DCCDIK:
				for j in range(mod.get_ccdik_data_chain_length()):
					mod.set_ccdik_joint_constraint_angle_min(j, 180 - mod.get_ccdik_joint_constraint_angle_min(j))
					mod.set_ccdik_joint_constraint_angle_max(j, 180 - mod.get_ccdik_joint_constraint_angle_max(j))
					#mod.set_ccdik_joint_constraint_angle_invert(j,!mod.get_ccdik_joint_constraint_angle_invert(j))
					mod.set_ccdik_joint_enable_constraint(j,true)
			elif mod is SkeletonModification2DLookAt:
				mod.set_constraint_angle_min(180-mod.get_constraint_angle_min())
				mod.set_constraint_angle_max(180-mod.get_constraint_angle_max())
				#mod.set_constraint_angle_invert(!mod.get_constraint_angle_invert())
				mod.set_enable_constraint(true)
		
		#print(stack.get_is_setup())
		stack.enable_all_modifications(true)
		print(stack.get_is_setup())
		#var temp:Vector2=rightFoot.global_position
		#rightFoot.global_position=leftFoot.global_position
		#leftFoot.global_position=temp
		
		#get_node("CharacterContainer/Bones/Skeleton2D/Hip").scale.x*=-1
		
		#head.global_position.x*=-1
		
		#var temp=rightArm.global_position
		#rightArm.global_position=leftArm.global_position
		#leftArm.global_position=temp
		
		#leftArm.global_position.x*=-1
		#rightArm.global_position.x*=-1
		
		
		#leftFoot.position=Vector2(0,135)
		#rightFoot.position=Vector2(0,135)
		
		#for i in $"IK Targets".get_children():
		#	i.position.x*=-1
		#for 
		fix_legs()

func call_detect_ground(body):
	if(legs_state.has_method("touched_ground")):
		legs_state.touched_ground(body)

func call_foot_on_ground(body):
	if(legs_state.has_method("foot_on_ground")):
		legs_state.foot_on_ground(body)

func _on_detect_ground_right_body_entered(body: Node2D) -> void:
	pass
	call_foot_on_ground(body)

func _on_detect_ground_left_body_entered(body: Node2D) -> void:
	pass
	call_foot_on_ground(body)


func _on_left_target_body_entered(body: Node2D) -> void:
	call_detect_ground(body)


func _on_right_target_body_entered(body: Node2D) -> void:
	call_detect_ground(body)


func _on_detect_ground_body_entered(body: Node2D) -> void:
	call_foot_on_ground(body)
