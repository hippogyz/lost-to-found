extends Node2D

signal game_over_signal()


export var game_over_waiting_time : float = 10.0
export var next_stage : PackedScene
export var outside_range : float = 1000
export var curtain_time : float = 3

var rest_try_time : int
var is_game_over = false
var is_fall = false
onready var player_m = get_node("Character")
const stage_clear = preload("res://gui/StageClear.tscn")
const game_over = preload("res://gui/GameOver.tscn")
func _ready() -> void:
	pass
	
func restart() -> void:
	get_tree().reload_current_scene()
		
		
func _process(delta) -> void:
	check_fall_play(delta)
	
func check_fall_play(delta : float):
	if not is_fall and (player_m.global_position.y - $AutoMove/Camera2D.get_camera_screen_center().y) > outside_range :
		is_fall = true
		$AutoMove.Velocity = Vector2(0, 0)
		game_over(-$AutoMove/Ruler.pixelToHeight(player_m.global_position.y) + $AutoMove/Ruler.Offset)
	if is_fall:
		$AutoMove/Curtain.visible = true
		$AutoMove/Curtain/ColorRect.color.a += delta / curtain_time
		if $AutoMove/Curtain/ColorRect.color.a >= 0.999:
			change_to_next_stage()	
	pass
func change_to_next_stage():
	get_tree().change_scene_to(next_stage)

func game_over(score : int) -> void:
	if(is_game_over):
		return
	is_game_over = true
	$AutoMove.Velocity = Vector2(0, 0)
	print("%s: game over" % get_tree().get_current_scene().get_name())
	var popup = game_over.instance()
	popup.score = score
	$AutoMove.add_child(popup)
	popup.connect("restart", self, "restart")
	emit_signal("game_over_signal")


