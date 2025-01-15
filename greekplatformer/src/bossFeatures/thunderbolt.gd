extends Area2D

class_name Thunderbolt

@export var speed:float=500
@export var target:Vector2

var velocity

const thunderScene: PackedScene = preload("res://src/bossFeatures/thunderbolt.tscn")

func _ready() -> void:
	velocity=(target - global_position).normalized() * speed
	rotation = velocity.angle() + PI/2
	

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.death()
		get_parent().get_parent().get_parent().camShake(0.3)
	else:
		get_parent().get_parent().get_parent().camShake(0.15)
	
	get_node("AnimatedSprite2D").play()
	
	velocity=Vector2.ZERO
	var t = create_tween()
	t.tween_interval(1)
	t.tween_callback(queue_free)
	
	#queue_free() #umjesto ovog ce ici neka animacija

static func new_thunderbolt(target_coords:Vector2) -> Thunderbolt:
	var thunder: Thunderbolt = thunderScene.instantiate()
	thunder.target=target_coords
	return thunder
