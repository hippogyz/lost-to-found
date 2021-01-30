extends KinematicBody2D

var _velocity : Vector2 = Vector2(200.0, 0.0)
var controlable : bool = true
var current_anima : String

func _ready() -> void:
	current_anima = "idle"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if controlable:
		var dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		move_and_slide(dir*_velocity)
		
		if dir > 0.0:
			play_anima("normal_walk")
			get_node("Sprite").scale.x = 1
		elif dir < 0.0 :
			play_anima("normal_walk")
			get_node("Sprite").scale.x = -1
		else:
			play_anima("idle")

func play_anima(anima_name : String) -> void:
	if current_anima != anima_name:
		get_node("AnimationTree").get("parameters/playback").travel(anima_name)
		current_anima = anima_name
