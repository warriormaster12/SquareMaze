extends Node2D
class_name PlayerController2D

@export var speed:float = 300

@onready var player_sprite: Sprite2D = $PlayerSprite
var level_info: LevelInfo = null
var stop_moving: bool = false

var move_tween: Tween = null
var direction: Vector2 = Vector2.ZERO
var last_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	level_info = get_owner()


func _input(_event: InputEvent) -> void:
	direction = Input.get_vector("move_l", "move_r", "move_u", "move_d")
	if direction.length() > 0:
		var next_pos: Vector2 = level_info.find_next_pos(direction)
		if next_pos.length() == 0:
			return
		var duration: float = next_pos.distance_to(global_position) / speed
		last_pos = global_position
		move_tween = create_tween()
		await move_tween.tween_property(self, "global_position", next_pos, duration).set_trans(Tween.TRANS_LINEAR).finished

func on_hit() -> void:
	if move_tween:
		move_tween.stop()
	global_position = last_pos
	level_info.last_pos()
