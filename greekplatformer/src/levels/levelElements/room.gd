extends Area2D

@export var rightOffset:int=0##offset kamere; desni dio sobe koji se nece vidjeti
@export var leftOffset:int=0##offset kamere; lijevi dio sobe koji se nece vidjeti
@export var upOffset:int=0##offset kamere; gornji dio sobe koji se nece vidjeti
@export var downOffset:int=0##offset kamere; donji dio sobe koji se nece vidjeti

func _ready() -> void:
	var room = $RoomSize.shape.size
	$Wall/CollisionPolygon2D.polygon[0] = Vector2(-room.x, -room.y)/2
	$Wall/CollisionPolygon2D.polygon[1] = Vector2(room.x, -room.y)/2
	$Wall/CollisionPolygon2D.polygon[2] = Vector2(room.x, room.y)/2
	$Wall/CollisionPolygon2D.polygon[3] = Vector2(-room.x, room.y)/2
	$Wall.global_position = $RoomSize.global_position
	
	#if(get_parent().current_room==self):
	#	pause_all_objects(false)

func pause_all_objects(togle:bool):
	var mode = Node.PROCESS_MODE_DISABLED
	if(get_parent().current_room==self and togle==false):
		mode=Node.PROCESS_MODE_INHERIT
	
	get_node("Objects").process_mode = mode

func _on_body_entered(_body: Node2D) -> void:
	get_parent().new_next_level=self

func _on_body_exited(_body: Node2D) -> void:
	if(get_parent().new_next_level==self):
		get_parent().new_next_level = get_parent().current_room
		return
	
	set_collision_mask_value(1,false)
	
	$Wall.set_collision_layer_value(2, true)
	get_parent().next_level()
	
	for i in get_node("Objects").get_children():
		if !(i is Throwable):
			i.queue_free()
		elif i != get_parent().get_node("Player").holding_object:
			i.queue_free()
