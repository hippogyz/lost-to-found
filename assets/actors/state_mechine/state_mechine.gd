extends Node

# if we want to add one class of state machine to control another (such as block animation), ...
# enum StateMechineMask {UPDATE = 1, HANDLEINPUT = 2, ANIMATION = 4}
# change enter_state() to change_state(StateMechineMask)
# add some interfaces such as play_current_animation() 

#signal state_changed_signal(new_state)

var state_map = {}
var current_state
export(NodePath) var start_state_path

var _active : bool = false

func _ready() -> void:
	if not start_state_path:
		start_state_path = get_child(0).get_path()
	for child in get_children(): 
		# the child node should be "state"
		child.connect( "state_exit_signal", self, "_change_state" )
	_initialize(start_state_path)

func _initialize(initial_state_path):
	set_active(true)
	current_state = get_node(initial_state_path)
	#current_state.enter_state()

func set_active( isActive : bool ) :
	_active = isActive
	set_physics_process(isActive)
	set_process_input(isActive)

func _change_state(next_state_name) :
	current_state.exit_state()
	current_state = state_map[next_state_name]
	current_state.enter_state()
	#emit_signal("state_changed_signal", current_state)

func _physics_process(delta: float) -> void:
	var pre_state = current_state
	current_state.update(delta)
	
	if pre_state != current_state:
		#print("state changed in update. from ", pre_state.name, " to ", current_state.name)
		pre_state = current_state
	
	current_state.handle_input()
	
	if pre_state != current_state:
		#print("state changed in handle. from ", pre_state.name, " to ", current_state.name)
		pre_state = current_state
