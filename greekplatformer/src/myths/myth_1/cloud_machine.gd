extends Node2D

const cloudScene = preload("res://src/myths/myth_1/credits_cloud.tscn")

var t=0.1

func _ready() -> void:
	createCloud()
	randomize()

func _process(delta: float) -> void:
	t = t - delta
	
	if t<0:
		#if randi_range(0,1)==0:
		#	t=randf_range(1,4)
		#else:
		t=randf_range(1,3)
		#var n = randi_range(1,2)
		#for i in range(n):
		createCloud()

func createCloud():
	var oblak = cloudScene.instantiate()
	add_child(oblak)
	oblak.global_position=global_position
	
	oblak.global_position.y = randf_range(-895, -142)
