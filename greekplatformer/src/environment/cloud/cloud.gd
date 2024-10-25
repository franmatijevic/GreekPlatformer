extends StaticBody2D

@export var time_to_disapear:float=1.0##koliko dugo player moze stajati na platformi prije nego sto nestane
@export var time_to_reapear:float=10##za koliko sekundi ce se platforma ponovo pojaviti

var disapeared:bool=false##je li nestala ili ne
var in_process_of_disapearing:bool=false

var timer:float=0

func _process(delta: float) -> void:
	if(disapeared):
		if(timer>0):
			timer-=delta
		else:
			reapear()
	elif(in_process_of_disapearing):
		if(timer>0):
			timer-=delta
		else:
			disapear()
	else:
		for i in $DetectObject.get_overlapping_bodies():
			if(i.global_position.y<global_position.y):
				if(i is Character and i.velocity.y>=0):
					start_disapearing()
				elif(i is Throwable and i.linear_velocity.y>=0):
					start_disapearing()

func reapear():
	disapeared=false
	in_process_of_disapearing=false
	visible=true
	get_node("CollisionShape2D").disabled=false

func disapear():
	visible=false
	get_node("CollisionShape2D").disabled=true
	disapeared=true
	timer = time_to_reapear

func start_disapearing():
	if(in_process_of_disapearing):
		return
	
	in_process_of_disapearing=true
	timer = time_to_disapear
	#tu moze neka animacija npr da se oblak trese prije nego sto nestane

func _on_detect_object_body_entered(body: Node2D) -> void:
	print("nesto")
	#start_disapearing()
	return
	if(body is Character):
		if(body.velocity.y>0):
			start_disapearing()
	elif(body is Throwable):
		if(body.linear_velocity>0):
			start_disapearing()
