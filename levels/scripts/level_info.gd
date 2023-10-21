extends Node2D
class_name LevelInfo

var targets: Array[Target2D] = []
var player: PlayerController2D = null

var current_target: int = 0
var last_target: int = 0
var next_target: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for target in get_tree().get_nodes_in_group("target"):
		targets.push_back(target)
	player = get_tree().get_nodes_in_group("player")[0]
	if targets.size() > 0 && player:
		player.global_position = targets[0].global_position

func find_next_pos(direction: Vector2) -> Vector2:
	var next_direction: Vector2 = player.global_position.direction_to(targets[next_target].global_position)
	var last_direction: Vector2 = player.global_position.direction_to(targets[last_target].global_position)
	if direction == next_direction:
		last_target = current_target
		current_target = next_target
		next_target = clamp(next_target + 1, 0, targets.size() - 1)
	elif direction == last_direction:
		next_target = current_target
		current_target = last_target
		last_target = clamp(last_target - 1, 0, targets.size() - 1)
	else:
		return Vector2.ZERO
	return targets[current_target].global_position

func last_pos() -> void:
	for i in range(0, targets.size()):
		var target: Target2D = targets[i]
		if target.global_position == player.last_pos:
			current_target = i
			break
	next_target = clamp(current_target + 1, 0, targets.size() - 1)
	last_target = clamp(current_target - 1, 0, targets.size() - 1)
	
