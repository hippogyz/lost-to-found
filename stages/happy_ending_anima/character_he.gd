extends KinematicBody2D

signal begin_to_walk(is_stop)

var _velocity : Vector2 = Vector2(200.0, 0.0)
var dir : float = 0.0
var current_anima : String
var playing_final : bool = false

func _ready() -> void:
	current_anima = ""


func play_anima(anima_name : String) -> void:
	if current_anima != anima_name:
		get_node("AnimationPlayer").play(anima_name)
		current_anima = anima_name
		dir = 0

func _ini_texture() -> void:
	$Sprite.visible = false
	$Sprite2.visible = true
	play_anima("fall")

func _onground_texture() -> void:
	$Sprite.visible = true
	$Sprite.frame = 5
	$Sprite/Sprite2.frame = 2
	$Sprite2.visible = false
	play_anima("sigh")


func anima_sigh_to_walk() -> void :
	play_anima("normal_walk")
	emit_signal("begin_to_walk", false)
	dir = 0.5

func _anima_hum(body: Node) -> void:
	play_anima("hum")
	dir = 0.75

func _anima_friend() -> void:
	var friends = $Sprite.get_children()
	for friend in friends:
		if friend.get_node("AppearAnimation") != null:
			friend.get_node("AppearAnimation").play("appear")

func _anima_final_of_final() -> void:
	play_anima("hum")
