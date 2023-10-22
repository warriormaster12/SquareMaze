extends Control

@onready var color_rect: ColorRect = $FadeColor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.color = Color(0,0,0,1)
	var tween: Tween = create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,0), 1.25).set_trans(Tween.TRANS_LINEAR)



func _on_start_pressed() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,1), 1.25).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	get_tree().change_scene_to_file("res://levels/level1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
