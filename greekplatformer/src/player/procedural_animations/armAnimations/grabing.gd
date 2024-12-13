extends State

var target

var speed=200

var armLength=100

var hip

var k

func enter():
	if(source().facing_direction):
		k=1
	else:
		k=-1
	
	hip=player().hip.position
	
	target=source().holding_object.get_node_or_null("Handle/Point")#.global_position
	if(target==null):
		target=source().holding_object

func update_physics_process(delta:float):
	if(abs(target.global_position.y - player().shoulder.global_position.y)>armLength):
		player().hip.position.y=move_toward(player().hip.position.y,target.global_position.y,speed*delta)
	if(abs(target.global_position.x - player().shoulder.global_position.x)>armLength):
		player().hip.rotation=move_toward(player().hip.rotation, PI/2*0.8  ,1.8*delta)
	
	
	player().leftArm.global_position=player().leftArm.global_position.move_toward(target.global_position, speed*delta)
	player().rightArm.global_position=player().rightArm.global_position.move_toward(target.global_position, speed*delta)

func exit():
	var t=create_tween()
	t.set_parallel(true)
	t.tween_property(player().hip, "position:y", hip.y, 0.1)
	t.tween_property(player().hip, "rotation", 0, 0.1)
