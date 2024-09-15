extends CharacterBody2D


var mov_vec = Vector2(0,0)
var speed = 700

var toss
var damage
var env_destroy = false

var timer
var destroy_at_end = false

func _ready() -> void:
	timer = get_tree().get_nodes_in_group("Timer")[0]
	velocity = mov_vec * speed

func _physics_process(delta):
	move_and_slide()


#for hurtboxes
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	
	enemy.mov_vec = mov_vec * toss
	enemy.take_damage(damage)
	destroy()

#for walls etc
func _on_area_2d_body_entered(body):
	if body["collision_layer"] == 2:
		destroy()

func destroy():
	queue_free()
