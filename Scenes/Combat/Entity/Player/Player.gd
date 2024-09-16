extends Entity


func custom_ready():
	$HurtBox["collision_layer"] = 4

func action_timer_start(recovery_time):
	timer.start(recovery_time)
