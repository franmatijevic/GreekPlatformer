extends Sprite2D

var state=0

var canKljuc:bool=false

func _ready() -> void:
	set_process(false)
	var tw = create_tween()
	tw.tween_interval(3)
	tw.tween_callback(start)

func start():
	AudioController.stop_all_music()
	set_process(true)

func _process(delta: float) -> void:
	match state:
		0:
			flying(delta)
		1:
			kljuc(delta)

func kljuc(delta):
	pass

func kljucAgain():
	canKljuc=false
	var tw = create_tween()
	tw.set_parallel(false)
	tw.tween_property(self, "rotation", deg_to_rad(-40), 0.1) #priprema
	tw.tween_property(self, "rotation", deg_to_rad(-30), 0.05) #udarac
	tw.tween_callback(click)
	tw.tween_property(self, "rotation", 0, 0.15) #povratak
	tw.tween_callback(kljucAgain)

func click():
	AudioController.play_sound($Click, 1,0)
	get_parent().get_parent().get_node("Blood").emitting=true

func flying(delta):
	
	get_parent().progress_ratio+=delta*0.4
	
	if get_parent().progress_ratio==1:
		state = 1
		get_parent().rotation=0
		kljucAgain()
		set_process(false)
