extends AnimatableBody2D

@onready var path = $".."

@export var speed:float = 100
#@export var loop:bool = false

@export var activated:bool=false

@export var shakeWhileActive:bool=false
@export var shakeAmount:float=0.0

var playerNearX:bool=false
var playerNearY:bool=false

var direction:Vector2=Vector2.ZERO

var player:Character=null

var timeToKill:float=0.3
var killtime:float=timeToKill

func _ready() -> void:
	set_physics_process(false)

func _process(_delta: float) -> void:
	if(path.progress_ratio!=0 and path.progress_ratio!=1):
		get_parent().get_parent().get_parent().get_parent().get_parent().setCamShake(shakeAmount)

func _physics_process(delta: float) -> void:
	var prev_position = global_position
	var oldDirection = direction
	
	var progress = speed
	if(!activated):
		progress = -speed
		if(path.progress_ratio==0):
			$DetectHorizontal.set_deferred("monitoring", false)
			$DetectVertical.set_deferred("monitoring", false)
			set_physics_process(false)
	
	path.progress += progress*delta
	
	direction = (global_position-prev_position).normalized()
	
	if(direction!=oldDirection):
		#killtime=timeToKill
		if(direction.x>0):
			$DetectHorizontal.position.x=abs($DetectHorizontal.position.x)
		elif(direction.x<0):
			$DetectHorizontal.position.x=-abs($DetectHorizontal.position.x)
		else:
			$DetectHorizontal.set_deferred("monitoring", false)
		if(direction.y>0):
			$DetectVertical.position.y=abs($DetectVertical.position.y)
		elif(direction.y<0):
			$DetectVertical.position.y=-abs($DetectVertical.position.y)
		else:
			$DetectVertical.set_deferred("monitoring", false)
	
	
	if(playerNearX):
		if(direction.x>0):
			pass
		elif(direction.x<0):
			pass
	if(playerNearY):
		if(direction.y>0):
			if player.is_on_floor():
				maybeSquash(delta)
		elif(direction.y<0):
			if player.is_on_ceiling():
				player.death()

func maybeSquash(delta:float):
	if timeToKill>=0:
		timeToKill-=delta
	elif(timeToKill<0):
		player.death()

func action(togle:bool):
	activated = togle
	set_physics_process(true)
	$DetectHorizontal.set_deferred("monitoring", true)
	$DetectVertical.set_deferred("monitoring", true)


func _on_detect_horizontal_body_entered(body: Node2D) -> void:
	timeToKill=killtime
	playerNearX=true
	player=body

func _on_detect_vertical_body_entered(body: Node2D) -> void:
	timeToKill=killtime
	playerNearY=true
	player=body

func _on_detect_horizontal_body_exited(_body: Node2D) -> void:
	timeToKill=killtime
	playerNearX=false

func _on_detect_vertical_body_exited(_body: Node2D) -> void:
	timeToKill=killtime
	playerNearY=false
