extends Node2D

@export var door_open: Door2D = null
@export var door_close: Door2D = null

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_owner().is_in_group("player"):
		if door_open:
			door_open.set("is_open", true)
		if door_close:
			door_close.set("is_open", false)
		visible = false
		audio_player.play()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
