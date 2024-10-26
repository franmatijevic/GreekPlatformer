extends Area2D

func _ready() -> void:
	pause_all_objects(false)

func pause_all_objects(togle:bool):
	var mode = Node.PROCESS_MODE_DISABLED
	if(get_parent().current_room==self and togle==false):
		mode=Node.PROCESS_MODE_INHERIT
	
	for i in get_node("Objects").get_children():
		i.process_mode=mode

func _on_body_entered(_body: Node2D) -> void:
	get_parent().new_next_level=self

func _on_body_exited(_body: Node2D) -> void:
	#set_deferred("monitorable", true)
	get_parent().next_level()
