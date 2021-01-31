extends Node2D

signal restart()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var score = 0
var is_time_out = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(3)
	$VC/CC2/Label2.text = "Wait " + String(int($Timer.get_time_left())) + " seconds..."
	$VC/CC3/HBoxContainer/Score.text = String(int(score))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_time_out:
		$VC/CC2/Label2.text = "Wait " + String(int($Timer.get_time_left())) + " seconds..."
	else:
		$VC/CC2/Label2.text = "Push W to Replay （^o^）"
		if Input.is_action_pressed("jump_order"):
			emit_signal("restart")
	pass





func _on_Timer_timeout():
	is_time_out = true
	pass # Replace with function body.
