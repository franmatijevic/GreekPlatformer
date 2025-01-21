extends Area2D

@export var path:String
var player:Character

var animationTime:float=0.8
var timer:float=animationTime
@onready var enter = $Enter

func _ready() -> void:
	set_physics_process(false)
	enter.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("up"):
		if(player==null):
			print("nista")
			return
		player.velocity.y=0
		player.process_mode=Node.PROCESS_MODE_DISABLED
		set_physics_process(true)
		var control = get_parent().get_parent().get_parent().get_node("BlackScreen/Control")
		create_tween().tween_property(control, "modulate:a", 1, animationTime)

func _physics_process(delta: float) -> void:
	if(player):
		player.velocity=Vector2.ZERO
	if(timer>0):
		timer-=delta
	else:
		SceneLoader.load_scene(path)
		set_physics_process(false)

func _on_body_entered(body: Node2D) -> void:
	player=body
	enter.visible = true

func _on_body_exited(_body: Node2D) -> void:
	player=null
	enter.visible = false
