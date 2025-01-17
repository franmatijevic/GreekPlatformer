extends Area2D

@export var idlePositionOffset:Vector2=Vector2.ZERO
@export var health:int=3

var currentAttack:int=0

var originalPosition

var prev_position

func _ready() -> void:
	prev_position=global_position
	for i in get_children():
		if i is State:
			i.reparent(get_node("Attacks"), 0)
			
			#if i is ZeusThunder:
			#	if i.hand1:
			#		i.hand1.state=0
			#	if i.hand2:
			#		i.hand2.state=0
			
	originalPosition=global_position + idlePositionOffset

func _physics_process(delta: float) -> void:
	
	get_node("Attacks").get_children()[currentAttack].update_physics_process(delta)

func rotateToFacing():
	if prev_position!=global_position:
		rotation = (global_position - prev_position).angle()
	
	if prev_position.x>global_position.x:
		$Head.flip_h=true
	else:
		$Head.flip_h=false



func next_attack():
	
	get_node("Attacks").get_children()[currentAttack].exit()
	currentAttack = currentAttack + 1
	if currentAttack == get_node("Attacks").get_child_count():
		currentAttack=0
	get_node("Attacks").get_children()[currentAttack].enter()

func take_damage():
	health=health-1
	if health==0:
		pass

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.death()
	if body is Throwable:
		take_damage()
