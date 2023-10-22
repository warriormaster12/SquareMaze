extends Node2D

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_owner().is_in_group("player"):
		var player: PlayerController2D = area.get_owner()
		player.global_position = global_position
		visible = false
		audio_player.play()
		player.level_finished()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
