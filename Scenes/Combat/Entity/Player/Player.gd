extends Entity


func custom_ready():
	$HurtBox["collision_layer"] = 4

func action_timer_start(recovery_time):
	timer.start(recovery_time)


func set_custom_deceleration(deceleration_custom_set):
	deceleration_custom_is = true
	deceleration_custom = deceleration_custom_set
