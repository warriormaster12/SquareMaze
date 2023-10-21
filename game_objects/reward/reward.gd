extends Node2D

@export var normal_trap_container: Node2D = null
@export var back_track_trap_container: Node2D = null

func _ready() -> void:
	if !normal_trap_container && !back_track_trap_container: 
		return
	back_track_trap_container.visible = false
	back_track_trap_container.process_mode = Node.PROCESS_MODE_DISABLED

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_owner().is_in_group("player"):
		back_track_trap_container.process_mode = Node.PROCESS_MODE_INHERIT
		back_track_trap_container.request_ready()
		back_track_trap_container.visible = true
		normal_trap_container.visible = false
		normal_trap_container.process_mode = Node.PROCESS_MODE_DISABLED
		queue_free()
