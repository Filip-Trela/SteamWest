extends CharacterBody2D


var mov_vec = Vector2(0,0)
var speed = 700

var toss
var damage

var timer

func _ready() -> void:
	timer = get_tree().get_nodes_in_group("Timer")[0]

func _physics_process(delta):
	if timer.paused:
		velocity = Vector2(0,0)
	else:
		velocity = mov_vec * speed
	
	move_and_slide()


#for hurtboxes
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	
	enemy.mov_vec = mov_vec * toss
	enemy.take_damage(damage)
	queue_free()

#for walls etc
func _on_area_2d_body_entered(body):
	if body["collision_layer"] == 2:
		queue_free()
