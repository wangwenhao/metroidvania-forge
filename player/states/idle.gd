class_name PlayerStateIdle extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("Idle")
	pass
	
func exit() -> void:
	pass

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		return jump
	return next_state

func process(_delta: float) -> PlayerState:
	if player.dirction.x != 0:
		return run
	elif player.dirction.y > 0.5:
		return crouch
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	if !player.is_on_floor():
		return fall
	return next_state
