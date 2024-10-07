extends Node


#entity on which is used
var entity
var state_time = 0.0
var timer


func _ready() -> void:
	custom_ready()
	$Timer.start(state_time)
	timer = get_tree().get_first_node_in_group("Timer")
	

func _process(delta: float) -> void:
	if timer.paused:
		$Timer.paused = true
	else:
		$Timer.paused = false
	
func custom_ready():
	pass
	#here it changes variables of entity


func end():
	pass
	#here put all changes to reverse


func _on_timer_timeout() -> void:
	end()
