extends StaticBody2D

const player_height = 64#PRIVREMENO

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
			if(i.global_position.y<global_position.y - player_height):
				if(i is Character and i.velocity.y>=0):
					start_disapearing()
				elif(i is Throwable and i.linear_velocity.y>=0):
					start_disapearing()

func reapear():
	disapeared=false
	in_process_of_disapearing=false
	visible=true
	
	create_tween().tween_property(self, "modulate:a", 1, 0.4)
	get_node("CollisionShape2D").disabled=false

func disapear():
	AudioController.play_cloud()
	visible=false
	get_node("CollisionShape2D").disabled=true
	disapeared=true
	timer = time_to_reapear

func start_disapearing():
	if(in_process_of_disapearing):
		return
	
	in_process_of_disapearing=true
	timer = time_to_disapear
	var tween = create_tween()
	
	tween.tween_interval(time_to_disapear*0.2)
	tween.chain().tween_property(self, "modulate:a", 0, time_to_disapear*0.8)
