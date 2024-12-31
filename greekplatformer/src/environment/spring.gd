extends Area2D

@export var max_force:float=800##Snaga opruge kojom te odgurne
@export var side_force:float=1200##nadodanje vertikalne sile na horizontalne opruge
@export var extra_force_multiplier:float = 0

const charge:float=0.1

var impact_velocity_y
var total_force:Vector2=Vector2.DOWN
var kept_force:Vector2=Vector2.DOWN

@onready var animatedSprite = $AnimatedSprite2D

func _ready() -> void:
	animatedSprite.play("default")
	total_force = Vector2(sin(rotation), -cos(rotation))*max_force#sin i cos su tako poslozeni jer se uracunava defaultno rotiranje za 90 stupnjeva u smjeru kazaljke na satu
	total_force.y -= abs(pow(sin(rotation),3)*side_force)
	#kept_force = Vector2(pow(abs(cos(rotation)),2), abs(sin(rotation))).normalized()
	#kept_force = Vector2(pow(abs(cos(rotation)),4), 0).normalized()
	kept_force = Vector2(abs(cos(rotation)), 0).normalized()

func _on_body_entered(body: Node2D) -> void:
	if($Timer.time_left>0):
		animatedSprite.play("default")
		return
	
	animatedSprite.play("spring_off")
	AudioController.play_spring()
	
	if(body is Character):
		#animatedSprite.play("spring_off")
		#AudioController.play_spring()
		#if(body.velocity.y>=0):
		impact_velocity_y = body.velocity.y
		#print(impact_velocity_y)
		$Timer.start(charge)
	elif(body is Throwable):
		##animatedSprite.play("default")
		
		#if(body.linear_velocity.y>=0):
		$Timer.start(charge)

func _on_timer_timeout() -> void:#odbacivanje tijela iz opruge
	for i in get_overlapping_bodies():
		if(i is Character):
			var impact_force = Vector2(0, -impact_velocity_y * extra_force_multiplier)
			var adjusted_total_force = total_force + impact_force
			
			#i.velocity=kept_force * i.velocity  + adjusted_total_force
			i.velocity = adjusted_total_force
			#i.velocity.y = -max_force
			i.jumped=false
		elif(i is Throwable):
			#var current = i.linear_velocity.normalized()
			#var springRotation = Vector2(sin(rotation), -cos(rotation))
			#var angle1 = (current - springRotation).angle()
			#var angle2 = (current + springRotation).angle()
			#var angle = -min(angle1, angle2)
			#springRotation.x= springRotation.x*cos(angle) - springRotation.y*sin(angle)
			#springRotation.y=springRotation.x*sin(angle) + springRotation.y*cos(angle)
			
			#i.linear_velocity = springRotation * i.linear_velocity.length() + total_force
			
			
			
			i.linear_velocity = kept_force * i.linear_velocity  + total_force
