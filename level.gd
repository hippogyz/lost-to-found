extends Node2D

signal game_over_signal()


export var game_over_waiting_time : float = 10.0
export var next_stage : PackedScene
export var outside_range : float = 1000
export var curtain_time : float = 3

var rest_try_time : int
var is_game_over = false
var is_fall = false
var max_height = 0
const weight_cubic = preload("res://assets/weight_cubic/weight.tscn")
onready var player_m = get_node("Character")
const stage_clear = preload("res://gui/StageClear.tscn")
const game_over = preload("res://gui/GameOver.tscn")
func _ready() -> void:
	pass
	
func restart() -> void:
	get_tree().reload_current_scene()
		
func update_difficult() -> void:
	$PlatContainer/spawner.scale_step = 200 + max_height 
	$PlatContainer/spawner.cloud_distance = 200 + max_height / 2
	$PlatContainer/spawner.scale_balance = 2 + max_height / 80
	if not is_fall:
		$AutoMove.Velocity.x = -1.0 + max_height / 400
		$AutoMove.Velocity.y = 0.4 + max_height / 1000
	
	
func _process(delta) -> void:
	max_height = max(-$AutoMove/Ruler.pixelToHeight(player_m.global_position.y) + $AutoMove/Ruler.Offset, max_height)
	check_fall_play(delta)
	update_difficult()
	
func check_fall_play(delta : float):
	if not is_fall and (player_m.global_position.y - $AutoMove/Camera2D.get_camera_screen_center().y) > outside_range :
		is_fall = true
		$AutoMove.Velocity = Vector2(0, 0)
		game_over(max_height)
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

export var spawn_cubic_range = 5

func _on_Character_spawn_cubic(pos, lose):
	var n = int(lose / 0.1)
	for i in range(n):
		var p = Vector2(randf(), randf()) * spawn_cubic_range + pos
		var w = weight_cubic.instance()
		w.global_position = p
		add_child(w) 
	pass # Replace with function body.
