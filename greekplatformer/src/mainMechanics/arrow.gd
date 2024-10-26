extends CharacterBody2D

class_name Arrow

const arrowScene: PackedScene = preload("res://src/mainMechanics/arrow.tscn")

@onready var ground = get_node("Ground/CollisionShape2D")

const SPEED:float=1000
var gravity:float=200

var frictionless_gravity:float=1000#gravitacija nakon sudara sa zidom,
#pojavljuje se ako strijela pogodi oblak i oblak nestane, orginalna gravitacija
#ima "uracunat" otpor zraka ili nesto jer kao brzo ide



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

func _on_detect_wall_body_entered(body: Node2D) -> void:
	if(body.get_parent() is Arrow):
		return
	
	rotation=velocity.angle()
	
	if((rotation>PI/2 and rotation<PI) or (rotation>-PI and rotation<-PI/2)):
		ground.get_parent().rotation = PI
	
	if(rotation>deg_to_rad(45) and rotation<deg_to_rad(135)): pass
	else: ground.set_deferred("disabled", false)
	
	stop=true
	velocity=Vector2.ZERO
	gravity=frictionless_gravity

func _on_detect_wall_body_exited(_body: Node2D) -> void:
	stop=false
	ground.set_deferred("disabled", true)
