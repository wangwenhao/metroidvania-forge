class_name PlayerStateRun extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state

func process(_delta: float) -> PlayerState:
	if player.dirction.x == 0:
		return idle
	elif player.dirction.y > 0.5:
		return crouch
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.dirction.x * player.move_speed
	if !player.is_on_floor():
		return fall
	return next_state
