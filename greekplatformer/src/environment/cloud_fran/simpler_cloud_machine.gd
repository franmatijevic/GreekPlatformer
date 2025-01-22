extends Node2D

const cloudScene = preload("res://src/myths/myth_1/credits_cloud.tscn")

var t=5

func _ready() -> void:
	createCloud()
	randomize()

func _process(delta: float) -> void:
	t = t - delta
	
	if t<0:
		t=randf_range(3,7)
		createCloud()

func createCloud():
	var oblak = cloudScene.instantiate()
	oblak.randomDistance=false
	add_child(oblak)
	oblak.global_position=global_position
	oblak.global_position.y = randf_range(-895, -142)
	
	if get_child_count()>=80:
		for i in range(40):
			get_children()[0].queue_free()
