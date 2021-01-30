extends Node2D

signal game_over_signal()


export var game_over_waiting_time : float = 10.0
export var next_stage : PackedScene

export var max_try_time : int = 10
var rest_try_time : int
var is_game_over = false
onready var player_m = get_node("Character")
const stage_clear = preload("res://gui/StageClear.tscn")
const game_over = preload("res://gui/GameOver.tscn")
func _ready() -> void:
	pass
	
func restart() -> void:
	get_tree().reload_current_scene()
		
func change_to_next_stage():
	get_tree().change_scene_to(next_stage)

func game_over(score : int) -> void:
	if(is_game_over):
		return
	is_game_over = true
	$AutoMove.Velocity = Vector2(0, 0)
	print("%s: game over" % get_tree().get_current_scene().get_name())
	var popup = game_over.instance()
	$AutoMove.add_child(popup)
	popup.connect("count_down_finish", self, "restart")
	emit_signal("game_over_signal")


func _on_spikes_player_on_spikes():
	$AutoMove.Velocity = Vector2(0, 0)
	game_over(5)
	pass # Replace with function body.
