extends CharacterBody2D



var mov_vec = Vector2(0,0)
var deceleration_normal = 9
var deceleration_coll = 30
var deceleration

var dir = Vector2(0,0)
var dir_current = Vector2(0,0)
var speed = 0
var max_speed = 600


func _ready() -> void:
	$Timer.start(1)
	deceleration = deceleration_normal

func _process(delta: float) -> void:
	if get_slide_collision_count():
		deceleration = deceleration_coll
	else:
		deceleration = deceleration_normal
		
func _physics_process(delta: float) -> void:
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

func _on_timer_timeout() -> void:
	queue_free()
