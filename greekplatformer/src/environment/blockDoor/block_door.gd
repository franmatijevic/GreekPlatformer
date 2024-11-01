extends AnimatableBody2D

@onready var path = $".."

@export var speed:float = 100

var activated:bool=false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	var progress = speed
	if(!activated):
		progress = -speed
		if(path.progress_ratio==0):
			set_physics_process(false)
	
	path.progress += progress*delta


func action(togle:bool):
	activated = togle
	set_physics_process(true)
