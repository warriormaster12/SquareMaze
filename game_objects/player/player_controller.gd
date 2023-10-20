extends Node2D
class_name PlayerController2D

@export var speed:float = 300

@onready var player_sprite: Sprite2D = $PlayerSprite
var level_info: LevelInfo = null

func _ready() -> void:
	level_info = get_owner()


func _input(event: InputEvent) -> void:
	var direction: Vector2 = Input.get_vector("move_l", "move_r", "move_u", "move_d")
	if direction.length() > 0:
		var next_pos: Vector2 = level_info.find_next_pos(direction)
		if next_pos.length() == 0:
			return
		var move_tween: Tween = create_tween()
		var duration: float = next_pos.distance_to(global_position) / speed
		await move_tween.tween_property(self, "position", next_pos, duration).set_trans(Tween.TRANS_LINEAR).finished

