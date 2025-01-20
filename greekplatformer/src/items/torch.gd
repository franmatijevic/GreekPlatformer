extends Throwable

class_name Torch

@export var absurdShake:bool=false

func be_picked_up(charact:Character):
	super(charact)
	if absurdShake==true:
		get_parent().get_parent().get_parent().longCamShake(0.5, 0.15)
		absurdShake=false
