extends KinematicBody2D

var _velocity : Vector2 = Vector2(200.0, 0.0)
var dir : float = 0.0
var controlable : bool = true
var current_anima : String
var playing_final : bool = false

func _ready() -> void:
	current_anima = "idle"
	controlable = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if controlable:
		dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
		if dir > 0.0:
			play_anima("normal_walk")
			get_node("Sprite").scale.x = 1
		elif dir < 0.0 :
			play_anima("normal_walk")
			get_node("Sprite").scale.x = -1
		else:
			play_anima("idle")
	
	move_and_slide(dir*_velocity)

func play_anima(anima_name : String) -> void:
	if current_anima != anima_name:
		get_node("AnimationTree").get("parameters/playback").travel(anima_name)
		current_anima = anima_name
		dir = 0



func _final_anima_trigger(body: Node) -> void:
	controlable = false
	play_anima("sigh")

func anima_sigh_to_walk() -> void :
	play_anima("normal_hum")
	dir = 0.5

func _anima_hum(body: Node) -> void:
	play_anima("hum")
	dir = 0.75

func _anima_friend(body: Node) -> void:
	play_anima("friend")
	dir = 0.0

func _anima_final_of_final() -> void:
	play_anima("hum")
