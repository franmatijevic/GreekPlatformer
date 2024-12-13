extends Marker2D

var is_stepping:bool=false

var stop:Vector2

var t=2*PI
var r=30
var k

func _ready() -> void:
	stop=global_position
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	print("neee")
	if(is_stepping):
		t=t+delta*15
		position.x = k*(r+1) + r*cos(t)
		position.y = r*sin(t) + 135
		
		if(t>PI/2 and get_node("RayCast2D").is_colliding()):
			stop_step()
	else:
		if(source().velocity.x!=0):
			global_position.x=stop.x
		if(source().velocity.y!=0):
			global_position.y=stop.y
		if(position.distance_to(Vector2(-2,130))>100):
			step()
			#relax()

func step():
	set_physics_process(true)
	if(is_stepping):
		return
	print("aha")
	if(source().velocity.x>0):
		k=1
	else:
		k=0
	
	is_stepping=true
	t=0

func stop_step():
	is_stepping=false
	t=0
	print("gotov saaaam")

func relax():
	set_physics_process(false)

func player():
	return get_parent().get_parent()

func source():
	return get_parent().get_parent().get_parent()
