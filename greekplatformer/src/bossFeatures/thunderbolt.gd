extends Area2D

class_name Thunderbolt

@export var speed:float=700
@export var target:Vector2

var velocity

const thunderScene: PackedScene = preload("res://src/bossFeatures/thunderbolt.tscn")

var hitGround:bool=false

func _ready() -> void:
	set_direction()

func set_direction():
	velocity=(target - global_position).normalized() * speed
	rotation = velocity.angle() + PI/2 + PI

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		if body.dead==true:
			return
		else:
			body.death()
			get_parent().get_parent().get_parent().camShake(0.3)
	else:
		get_parent().get_parent().get_parent().camShake(0.15)
	
	get_node("AnimatedSprite2D").play()
	
	velocity=Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	
	var t = create_tween()
	t.tween_interval(0.5)
	t.tween_callback(queue_free)
	
	#queue_free() #umjesto ovog ce ici neka animacija

static func new_thunderbolt(target_coords:Vector2) -> Thunderbolt:
	var thunder: Thunderbolt = thunderScene.instantiate()
	thunder.target=target_coords
	return thunder
