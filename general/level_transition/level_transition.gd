@tool
@icon("res://general/icons/level_transition.svg")
class_name LevelTransition extends Node2D

enum SIDE {
	LEFT, RIGHT, UP, DOWN
}

@export_range(2, 16, 1, "or_greater") var size: int = 2:
	set(value):
		size = value
		apply_area_settings()

@export var location: SIDE = SIDE.LEFT:
	set(value):
		location = value
		apply_area_settings()

@export_file("*.tscn") var target_level: String = ""
@export var target_area_name: String = "LevelTransition"

@onready var area: Area2D = $Area2D

func apply_area_settings() -> void:
	area = get_node_or_null("Area2D")
	if not area:
		return
	
	if location == SIDE.LEFT or location == SIDE.RIGHT:
		area.scale.y = size
		if location == SIDE.LEFT:
			area.scale.x = -1
		else:
			area.scale.x = 1
	else:
		area.scale.x = size
		if location == SIDE.UP:
			area.scale.y = 1
		else:
			area.scale.y = -1
