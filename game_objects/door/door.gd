extends Node2D
class_name  Door2D

@export var is_open: bool = true:
	set(value):
		is_open = value
		if is_inside_tree():
			set_door_state(value)
@export var duration:float = 0.3
@onready var collision: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	set_door_state(is_open)
func set_door_state(state:bool) -> void:
	var tween: Tween = create_tween()
	if state:
		await tween.tween_property(self, "scale", Vector2(scale.x, 0.0), duration).set_trans(Tween.TRANS_LINEAR).finished
		collision.call_deferred("set_disabled", true)
	else:
		collision.call_deferred("set_disabled", false)
		await tween.tween_property(self, "scale", Vector2(scale.x, 1.0), duration).set_trans(Tween.TRANS_LINEAR).finished
		
