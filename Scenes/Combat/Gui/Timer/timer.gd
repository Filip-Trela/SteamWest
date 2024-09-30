extends Label

var minutes:int =0
var seconds:int =0
var msec:float =0.0

var strmin
var strsec
var strmsec

var director

var time_set = 360
var time:float = 0.0
@onready var timer = $Timer

var paused = true
var target_time:float

var disable = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_ready()

func custom_ready():
	director = get_tree().get_nodes_in_group("Director")
	director = director[0]
	
	timer.start(time_set)
	timer.paused = true
	paused = true
	
	for effect in get_tree().get_nodes_in_group("Effect"):
		effect["process_mode"] = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time = time_set - timer.time_left
	
	if not paused:
		if time >= target_time:
			
			director.next_turn()
			timer.paused = true
			paused = true
			disable = true
	if disable:
		for effect in get_tree().get_nodes_in_group("Effect"):
			effect["process_mode"] = Node.PROCESS_MODE_DISABLED
		for skill in get_tree().get_nodes_in_group("Skill"):
			skill["process_mode"] = Node.PROCESS_MODE_DISABLED
	
	set_label()

func start(recovery_time):
	disable = false
	paused = false
	timer.paused = false
	
	director.during_action()
	
	target_time = time + recovery_time
	for effect in get_tree().get_nodes_in_group("Effect"):
		effect["process_mode"] = Node.PROCESS_MODE_INHERIT
	for skill in get_tree().get_nodes_in_group("Skill"):
		skill["process_mode"] = Node.PROCESS_MODE_INHERIT

func set_label():
	minutes = int(time)/60
	seconds = int(time)%60
	msec = time - float(int(time))
	
	if len(str(minutes)) != 2:
		strmin = "0" + str(minutes)
	else:
		strsec = str(seconds)
		
	if len(str(seconds)) != 2:
		strsec = "0" + str(seconds)
	else:
		strsec = str(seconds)
	
	if len(str(msec)) > 3:
		strmsec = str(msec)[2] + str(msec)[3]
	else:
		strmsec = "00"
	
	
	text = strmin + ':' +strsec+ ':' +strmsec
