extends Control

signal count_down_finish()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VC/CC2/Label2.text = String(int($Timer.time_left))
	pass


func _on_Timer_timeout():
	emit_signal("count_down_finish")
	pass # Replace with function body.
