extends Node2D

export var Ratio = 1
export var Offset = 200
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func pixelToHeight(pixel_height : float) -> float:
	return pixel_height / Ratio
func heightToPixel(height : float) -> float:
	return height * Ratio
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$m1.middle = pixelToHeight(500) / 2
	$m2.middle = pixelToHeight(500) / 2
	$m3.middle = pixelToHeight(500) / 2
	$m4.middle = pixelToHeight(500) / 2
	refresh_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	refresh_position()

func refresh_position():
	var now_height = global_position.y
	var begin = int((now_height / 500 - 1)) * 500
	$m1.global_position.y = begin 
	$m1.height = (-begin) / Ratio + Offset
	$m2.global_position.y = begin + 500
	$m2.height = (-begin - 500) / Ratio + Offset
	$m3.global_position.y = begin + 1000
	$m3.height = (-begin - 1000) / Ratio + Offset
	$m4.global_position.y = begin + 1500
	$m4.height = (-begin - 1500) / Ratio + Offset
