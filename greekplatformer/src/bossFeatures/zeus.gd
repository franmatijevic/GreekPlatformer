extends Area2D

@export var idlePositionOffset:Vector2=Vector2.ZERO
@export var health:int=3

@export var flip:bool=false

@export var connectedTo:Array[Node] = []

var currentAttack:int=0

var originalPosition

var prev_position

var immunity:bool=false

func _ready() -> void:
	if flip:
		scale.x=-1
	
	prev_position=global_position
	for i in get_children():
		if i is State:
			i.reparent(get_node("Attacks"), 0)
			
			
	originalPosition=global_position + idlePositionOffset

func _physics_process(delta: float) -> void:
	
	match currentAttack:
		-1:
			global_position.y-=delta*100
		_:
			get_node("Attacks").get_children()[currentAttack].update_physics_process(delta)

func rotateToFacing():
	return
	if prev_position!=global_position:
		rotation = (global_position - prev_position).angle()
	
	if prev_position.x>global_position.x:
		scale.x=-1
		#$Head.flip_h=true
	else:
		scale.x=1
		#$Head.flip_h=false



func next_attack():
	get_node("Attacks").get_children()[currentAttack].exit()
	currentAttack = currentAttack + 1
	if currentAttack == get_node("Attacks").get_child_count():
		currentAttack=0
	get_node("Attacks").get_children()[currentAttack].enter()

func take_damage():
	if immunity==true:
		return
	
	health=health-1
	if health==0:
		do_action(true)
		currentAttack=-1
		var t = create_tween()
		t.tween_property($Head, "modulate:a", 0, 2)
		
	else:
		get_parent().get_parent().get_parent().camShake(0.25)
		immunity=true
		var t = create_tween()
		t.set_parallel(false)
		for i in range(5):
			t.tween_property($Head, "modulate:a", 0.7, 0.2)
			t.tween_property($Head, "modulate:a", 1, 0.2)
		t.tween_callback(end_taking_damage)
		t.tween_property($Head, "modulate:a", 0.7, 0.2)
		t.tween_property($Head, "modulate:a", 1, 0.2)

func end_taking_damage():
	immunity=false

func do_action(togle:bool):
	for i in connectedTo:
		i.action(togle)

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.death()
	if body is Throwable:
		if body.linear_velocity==Vector2.ZERO:
			return
		body.linear_velocity.x*=-1
		body.linear_velocity.y-=400
		take_damage()
