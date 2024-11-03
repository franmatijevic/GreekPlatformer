extends State

var time:float=3

func enter():
	#player().modulate.r=1
	time=1
	#player().set_collision_layer_value(1, false)
	
	player().dead=true
	
	var black = player().get_parent().get_node("BlackScreen/Control")
	var tween = create_tween()
	tween.tween_interval(0.6)
	tween.tween_property(black, "modulate:a", 0.3, 0.4)
	
	
	if(player().holding_object):
		player().throw( Vector2(player().velocity.x, -10) )

func update_physics_process(delta:float):
	if time>0:
		time-=delta
		player().rotation+=delta*5
	else:
		player().get_parent().restart()

func exit():
	#player().modulate.r=0
	player().dead=false
	player().rotation=0
	#player().set_collision_layer_value(1, true)
