class_name Player extends CharacterBody2D

#region /// Export Variables
@export var move_speed: float = 150
#endregion

#region /// State Machine Variables
var states: Array[PlayerState]
var current_state: PlayerState:
	get: return states.front()
var last_state: PlayerState:
	get: return states[1]
#endregion

#region /// Standard Variables
var dirction: Vector2 = Vector2.ZERO
var gravity: float = 980
#endregion

func _ready() -> void:
	initialize_state()
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))

func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	
func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta
	move_and_slide()
	change_state(current_state.physics_process(_delta))

func initialize_state() -> void:
	states = []
	for c in $State.get_children():
		if c is PlayerState:
			states.append(c)
			c.player = self
			
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
	
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name

func change_state(new_state: PlayerState) -> void:
	if new_state == null:
		return

	if new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	$Label.text = current_state.name

func update_direction() -> void:
	#var prev_direction: Vector2 = dirction
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	dirction = Vector2(x_axis, y_axis)
	
