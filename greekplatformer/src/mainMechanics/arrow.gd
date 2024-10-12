extends CharacterBody2D

class_name Arrow

const arrowScene: PackedScene = preload("res://src/mainMechanics/arrow.tscn")

const SPEED:float=1000
const gravity:float=200

var stop:bool=false

static func new_arrow(shooting_direction:float) -> Arrow:
	var arrow: Arrow = arrowScene.instantiate()
	
	arrow.velocity.x=SPEED * cos(shooting_direction)
	arrow.velocity.y=SPEED * sin(shooting_direction)
	
	return arrow

func _process(_delta: float) -> void:
	if(!stop):
		#get_node("Sprite").
		rotation=velocity.angle()

func _physics_process(delta: float) -> void:
	if(!stop):
		velocity.y+=gravity*delta
		move_and_slide()

func _on_detect_wall_body_entered(_body: Node2D) -> void:
	rotation=velocity.angle()
	stop=true
	velocity=Vector2.ZERO
