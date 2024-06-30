extends CharacterBody2D

class_name Entity



var mov_vec = Vector2(0,0)
var deceleration = 10


func _physics_process(delta):
	
	mov_vec = mov_vec.move_toward(Vector2(0,0), deceleration)
	
	velocity = mov_vec
	move_and_slide()



