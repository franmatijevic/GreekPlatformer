extends Level

const torchScene: PackedScene = preload("res://src/items/torch.tscn")

@export var torch:Throwable

func _ready() -> void:
	super()
	put_torch_in_player_hand()
	#$Rain.play()

func teleport(spot):
	super(spot)
	
	put_torch_in_player_hand()

func put_torch_in_player_hand():
	if torch!=null:
		torch.queue_free()
	torch = new_torch()
	
	torch.be_picked_up(get_node("Player"))
	torch.global_position = get_node("Player").global_position
	
	get_node("Player").holding_object = torch
	get_node("Player/ProceduralAnimation").set_arms("Holding")

func new_torch():
	var tor = torchScene.instantiate()
	add_child(tor)
	return tor

func next_level():
	super()
	if get_node("Player").holding_object !=torch:
		if get_node("Player").holding_object!=null:
			holding_object.queue_free()
		put_torch_in_player_hand()
