extends Node2D

@onready var arm = $"Lik-torso/Nadlaktica"
@onready var hip = $"Lik-torso"

@onready var bedro1 = $"Lik-torso/Bedro"
@onready var bedro2 = $"Lik-torso/Bedro2"

var t = -5
var nOfSwings=1

var duration=0

var handRaising=0.4
var wavingDuration=0.3

##kutovi
var rest = -0.2268928028
var highest = -1.8151424221
var lowered = -1.4835298642

var state = 0 #0 - chill, 1-handraising, 2 - completeLower, 3 -mini lower, 4 - mini raise


var hipTime=0
var maxHipBend=PI/24

func _ready() -> void:
	randomize()
	hipTime=randf_range(0, 2*PI)
	wave()


func _process(delta: float) -> void:
	t=t+delta
	if t>0:
		wave()
	
	hipTime = hipTime +delta
	hip.rotation = sin(hipTime)*maxHipBend + PI/6 + maxHipBend/2
	bedro1.rotation = PI/4 + PI/6 - hip.rotation
	bedro2.rotation = PI/4 + PI/6 - hip.rotation

func wave():
	var tw = create_tween()
	tw.set_parallel(false)
	tw.tween_property(arm, "rotation", highest, handRaising)
	for i in range(nOfSwings):
		tw.tween_property(arm, "rotation", lowered, wavingDuration/2)
		tw.tween_property(arm, "rotation", highest, wavingDuration/2)
	tw.tween_property(arm, "rotation", rest, handRaising)
	
	t = -randf_range(5, 7)
	nOfSwings = randi_range(0,3)
