extends Node2D

var description:String
var amount:String
var type:String


var text_set


func _ready():
	$Label.text = text_set[0]
	$Label2.text = text_set[1]
	type = text_set[2]
