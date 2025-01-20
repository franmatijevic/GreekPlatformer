extends State

const minAngle:float=0
const maxAngle:float=PI /20

const maxHeight=45
const minHeight=45+15

const angleSpeed=0.5
const heigthSpeed=50

#var k=0
var t=0

var angleTarget
var height


func enter():
	t=PI/8

#func update_physics_process(delta:float):
func update_process(delta:float):
	t=t+delta

	var k=player().k
	angleTarget = (sin(t) *(minAngle-maxAngle*k) + (minAngle+maxAngle*k) )/2.0
	
	player().hip.rotation=move_toward(player().hip.rotation, angleTarget, angleSpeed*delta)
	player().hip.position.y=move_toward(player().hip.position.y, maxHeight, heigthSpeed*delta)
	
	#player().hip.position.y=move_toward(player().hip.position.y, maxHeight+3 +3*sin(PI-t), 20*delta)
	
	#player().targetLeftLeg.position.y=move_toward(player().targetLeftLeg.position.y, 120, heigthSpeed*delta)
	#player().targetRightLeg.position.y=move_toward(player().targetRightLeg.position.y, 120, heigthSpeed*delta)
	
	if(source().velocity.x!=0 or !source().is_on_floor()):
		player().set_hip("Moving")
