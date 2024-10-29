extends Area2D

func _ready() -> void:
	pause_all_objects(false)

	var room = $RoomSize.shape.size
	$Wall/CollisionPolygon2D.polygon[0] = Vector2(-room.x, -room.y)/2
	$Wall/CollisionPolygon2D.polygon[1] = Vector2(room.x, -room.y)/2
	$Wall/CollisionPolygon2D.polygon[2] = Vector2(room.x, room.y)/2
	$Wall/CollisionPolygon2D.polygon[3] = Vector2(-room.x, room.y)/2
	$Wall.global_position = $RoomSize.global_position

func pause_all_objects(togle:bool):
	var mode = Node.PROCESS_MODE_DISABLED
	if(get_parent().current_room==self and togle==false):
		mode=Node.PROCESS_MODE_INHERIT
	
	get_node("Objects").process_mode = mode

func _on_body_entered(_body: Node2D) -> void:
	
	get_parent().new_next_level=self

func _on_body_exited(_body: Node2D) -> void:
	if(get_parent().new_next_level==self):
		return
	
	set_collision_mask_value(1,false)
	
	$Wall.set_collision_layer_value(2, true)
	get_parent().next_level()
