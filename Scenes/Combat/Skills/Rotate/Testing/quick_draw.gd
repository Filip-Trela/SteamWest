extends CharacterBody2D


var mov_vec = Vector2(0,0)
var speed = 700

var toss
var damage
var env_destroy_index

var timer


var danger_type = "moving" #static(like move, area circle) moving (like bullets)
var entity

func _ready() -> void:
	timer = get_tree().get_nodes_in_group("Timer")[0]
	velocity = mov_vec * speed
	$RotatePart.rotation = mov_vec.angle()

func _physics_process(delta):
	move_and_slide()


#for hurtboxes
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	
	enemy.take_damage(damage, mov_vec, toss)
	destroy()

#for walls etc
func _on_area_2d_body_entered(body):
	if body["collision_layer"] == 2:
		destroy()

func destroy():
	queue_free()

func interactable_enviroment_hit():
	env_destroy_index -= 1
	if env_destroy_index <1:
		destroy()
