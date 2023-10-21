extends Node2D

@export var normal_trap_container: Node2D = null
@export var back_track_trap_container: Node2D = null
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	if !normal_trap_container && !back_track_trap_container: 
		return
	back_track_trap_container.visible = false
	back_track_trap_container.process_mode = Node.PROCESS_MODE_DISABLED

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_owner().is_in_group("player"):
		for child in back_track_trap_container.get_children():
			child.request_ready()
		back_track_trap_container.process_mode = Node.PROCESS_MODE_INHERIT
		back_track_trap_container.visible = true
		normal_trap_container.visible = false
		normal_trap_container.process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
		audio_player.play()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
