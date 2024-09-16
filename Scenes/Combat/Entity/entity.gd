extends CharacterBody2D

class_name Entity

var health = 20

var mov_vec = Vector2(0,0)
var deceleration_normal = 9
var deceleration_coll = 30
var deceleration

var dir = Vector2(0,0)
var dir_current = Vector2(0,0)
var speed = 0
var max_speed = 600

var timer

func _ready() -> void:
	timer = get_tree().get_nodes_in_group("Timer")[0]
	deceleration = deceleration_normal
	custom_ready()
	
	#TESTING
	dir = Vector2(0,1)
	speed = 1
	
func custom_ready():
	pass
	

func _process(delta: float) -> void:
	if get_slide_collision_count():
		deceleration = deceleration_coll
	else:
		deceleration = deceleration_normal
		
	custom_process()

func custom_process(): 
	pass


func _physics_process(delta):
	if timer.paused:
		velocity = Vector2(0,0)
		
	else:
		if dir_current == Vector2(0,0) and dir != Vector2(0,0):
			dir_current = dir
			dir = Vector2(0,0)
		
		elif dir_current != Vector2(0,0) and dir != Vector2(0,0):
			dir_current = dir_current.move_toward(dir, 0.07)
		
		if speed ==0:
			dir = Vector2(0,0)
			dir_current = Vector2(0,0)
		
		speed = move_toward(speed, 0, deceleration)
		speed = clamp(speed, 0, max_speed)
		
		mov_vec = dir_current * speed
		velocity = mov_vec
	
	
	move_and_slide()
	
	
	
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	queue_free()
