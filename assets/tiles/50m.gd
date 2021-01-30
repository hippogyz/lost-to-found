extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var height = 100
export var middle = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$BigLabel.text = String(int(height))
	$m/MiddleLabel.text = String(int(height) - middle)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
