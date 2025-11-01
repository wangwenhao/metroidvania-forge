class_name PlayerStateRun extends PlayerState



func init() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	return next_state

func process(_delta: float) -> PlayerState:
	if player.dirction.x == 0:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.dirction.x * player.move_speed
	return next_state
