extends Node2D

var player
var camera
var invert

var t:float=10
@export var offsetY:float=-55
@export var shouldBeFlipped:bool=false##lijeva i desna ruka

@export var spaceBetweenHands:float=128*4

var timeBetweenShoots:float=10

@export var activeOnStart:bool=true

var state=1
var targetPosition:Vector2=Vector2.ZERO #pozicija relativna kameri

var horizontalVelocity:float=0

var target #meta kada puca direktno

func _ready() -> void:
	if !activeOnStart:
		state=0
		targetPosition.y=-300
	
	player = get_parent().get_parent().get_parent().get_node("Player")
	camera = get_parent().get_parent().get_parent().get_node("Camera/Camera2D")
	invert = get_parent().get_parent().get_parent().get_node("InvertTelegraph")
	
	if( shouldBeFlipped):
		scale.x=-1

func _process(delta: float) -> void:
	
	#func _physics_process(delta: float) -> void:
	#var height = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2 + offsetY
	
	match state:
		0: #hidden
			invert.visible = false
			targetPosition.y = move_toward(targetPosition.y, -300, 100*delta)
		1: #agressive
			agressive(delta)
		2: #direct shot
			direct(delta)
	
	
	global_position.y = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2 + offsetY + targetPosition.y

func direct(delta):
	
	global_position.x = move_toward(global_position.x, target, horizontalVelocity*delta)
	
	if t>0:
		t=t-delta	
	elif global_position.x == target:
		shoot_down()
		t=15
	
	targetPosition.y = move_toward(targetPosition.y, 0, 100*delta)

func agressive(delta:float):
	var k=1
	if(shouldBeFlipped): k=-1
	
	targetPosition.x = player.global_position.x - spaceBetweenHands*k
	
	var distance = min(abs(targetPosition.x - global_position.x), 1200)
	
	var acc = ((distance/1200))*500 + 500
	
	
	if distance>20:
		if targetPosition.x>global_position.x:
			horizontalVelocity = move_toward(horizontalVelocity, 1000, acc*delta)
		else:
			horizontalVelocity = move_toward(horizontalVelocity, -1000, acc*delta)
	else:
		horizontalVelocity = move_toward(horizontalVelocity, 0, 300*delta)
	
	global_position.x += horizontalVelocity*delta
	

	if t > 0.67:
		invert.visible = false
	elif t > 0.33:
		invert.visible = true
	else:
		invert.visible = false
	
	if t>1.99:
		t=t-delta
		invert.visible = false
		hold(false)
	elif t>0:
		t=t-delta
		hold(true)
	else:
		shoot()
		hold(false)
		invert.visible = false
		t=timeBetweenShoots
	
	
	targetPosition.y = move_toward(targetPosition.y, 0, 100*delta)

func shoot_down():
	var thunder = Thunderbolt.new_thunderbolt(Vector2(target,global_position.y+1000))
	thunder.global_position=global_position
	get_parent().add_child(thunder)
	thunder.global_position=Vector2(target,global_position.y+1000)
	thunder.set_direction()


func shoot():
	AudioController.play_thunder()
	invert.visible = false
	var thunder = Thunderbolt.new_thunderbolt(player.global_position)
	thunder.global_position=global_position
	get_parent().add_child(thunder)
	thunder.global_position=global_position
	thunder.set_direction()
	#player().get_parent().current_room.get_node("Objects").add_child(arrow)

func hold(togle:bool):
	$Ruka.visible = !togle
	$RukaMunja.visible = togle
