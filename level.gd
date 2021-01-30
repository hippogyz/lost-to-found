extends Node2D

signal game_over_signal()
signal victory_signal()
signal try_times_updated(t)

export var game_over_waiting_time : float = 10.0
export var next_stage : PackedScene
var is_game_over : bool
var is_victory : bool

export var max_try_time : int = 10
var rest_try_time : int

onready var player_m = get_node("player")
onready var npc_list = get_node("NPCList").get_children()
const stage_clear = preload("res://gui/StageClear.tscn")
const game_over = preload("res://gui/GameOver.tscn")
const all_clear = preload("res://gui/AllStageClear.tscn")
func _ready() -> void:
	is_game_over = false
	is_victory = false
	rest_try_time = max_try_time
	player_m.connect("reduce_rest_time_signal",self, "reduce_rest_time")
	player_m.connect("change_sight_signal", self, "change_sight")
	
	self.connect("try_times_updated", $GUI/HBox/MC2/VC/PowerPanel, "_on_try_times_updated")
	emit_signal("try_times_updated", rest_try_time)
	

func _physics_process(delta: float) -> void:
	_update_npc_state(delta)
	_judge_victory()
	_judge_game_over(delta)

func reduce_rest_time() -> void:
	rest_try_time -= 1
	emit_signal("try_times_updated", rest_try_time)
	if rest_try_time == 0: 
		is_game_over = true
		player_m.forbid_take_alert()

func _restart() -> void:
	rest_try_time = max_try_time
	is_game_over = false
	player_m.permit_take_alert()

func _update_npc_state(delta:float) -> void :
	for npc in npc_list:
		npc.get_node("Ball").cut_rest_life_time(delta)
	
	for npc in npc_list:
		npc.get_node("Ball").cal_next_state()
	
	for npc in npc_list:
		npc.get_node("Ball").update_state()

func _judge_victory() -> void:
	if is_victory: 
		return 
	
	var result = true
	for npc in npc_list:
		result = result && npc.get_node("Ball").judge_victory()
	
	if result:
		is_victory = true
		print("%s: stage clear." % get_tree().get_current_scene().get_name())
		if get_tree().get_current_scene().get_name() == "StageEnd":
			var popup = all_clear.instance()
			add_child(popup)
			return
		emit_signal("victory_signal")
		var popup = stage_clear.instance()
		add_child(popup)
		popup.connect("count_down_finish", self, "change_to_next_stage")
		
func change_to_next_stage():
	get_tree().change_scene_to(next_stage)
	
func restart_self():
	get_tree().reload_current_scene()

func _judge_game_over(delta:float) -> void:
		if is_game_over && game_over_waiting_time > 0 && !is_victory:
			game_over_waiting_time -= delta
			if game_over_waiting_time <= 0:
				print("%s: game over" % get_tree().get_current_scene().get_name())
				emit_signal("victory_signal")
				var popup = game_over.instance()
				add_child(popup)
				popup.connect("count_down_finish", self, "restart_self")
				emit_signal("game_over_signal")
				
func is_end() -> bool:
	return is_game_over or is_victory

func change_sight(sight_index) ->void:
	player_m.change_exhibit_mode(sight_index)
	for npc in npc_list:
		npc.get_node("Orbit").change_exhibit_mode(sight_index)
