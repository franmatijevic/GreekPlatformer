extends Throwable

class_name Torch

@export var absurdShake:bool=false

var floor
var floorPrevPos


func be_picked_up(charact:Character):
	super(charact)
	if absurdShake==true:
		get_parent().get_parent().get_parent().longCamShake(0.5, 0.15)
		absurdShake=false

func _physics_process(delta):
	super(delta)
	if floor and !pickedUp:
		if floorPrevPos:
			var vel = (-floorPrevPos + floor.global_position)
			global_position += vel * 0.9
			#linear_velocity +=vel
			#constant_force = vel
		
		floorPrevPos=floor.global_position

func be_thrown(force:Vector2):
	AudioController.positionSound($Flame, 1)
	super(force)

func _on_detect_block_door_body_entered(body: Node2D) -> void:
	if body is BlockDoor:
		floor = body


func _on_detect_block_door_body_exited(body: Node2D) -> void:
	if body is BlockDoor:
		floor = null
		floorPrevPos=null
		constant_force =Vector2.ZERO
