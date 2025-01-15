extends Node2D

var player
var camera

var t:float=10
@export var offsetY:float=-55
@export var shouldBeFlipped:bool=false##lijeva i desna ruka

@export var spaceBetweenHands:float=128*4

@export var timeBetweenShoots:float=5

@export var activeOnStart:bool=true

var state=1
var targetPosition:Vector2=Vector2.ZERO #pozicija relativna kameri

var horizontalVelocity:float=0

func _ready() -> void:
	player = get_parent().get_parent().get_parent().get_node("Player")
	camera = get_parent().get_parent().get_parent().get_node("Camera/Camera2D")
	
	if( shouldBeFlipped):
		$Line2D.scale.x=-1

func _physics_process(delta: float) -> void:
	var height = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2 + offsetY
	
	match state:
		0: #hidden
			targetPosition.y = move_toward(targetPosition.y, -300, 100*delta)
		1: #agressive
			agressive(delta)
	
	
	global_position.y = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2 + offsetY + targetPosition.y

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
	
	
	
	if t>0:
		t=t-delta
	else:
		shoot()
		t=timeBetweenShoots
	
	targetPosition.y = move_toward(targetPosition.y, 0, 100*delta)

func shoot():
	var thunder = Thunderbolt.new_thunderbolt(player.global_position)
	thunder.global_position=global_position
	get_parent().add_child(thunder)
	#player().get_parent().current_room.get_node("Objects").add_child(arrow)
