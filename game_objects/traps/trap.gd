extends Node2D

@export var buffer_wait:float = 0.0
@export var duration: float = 0.2
@export var hidden_wait_time: float = 0.5
@export var wait_time: float = 2.0
@export var max_scale: float = 0.8
@onready var timer: Timer = $WaitTime
@onready var area: Area2D = $TriangleTrap/Area2D
@onready var hit_player: AudioStreamPlayer2D = $HitAudioPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer2D

var hit: bool = false

func _ready() -> void:
	timer.set_wait_time(hidden_wait_time)
	timer.set_one_shot(true)
	scale = Vector2(max_scale, 0)
	area.area_entered.connect(_on_area_2d_area_entered)
	if buffer_wait > 0.0:
		await get_tree().create_timer(buffer_wait).timeout
	timer.start()

func _on_wait_time_timeout() -> void:
	var tween: Tween = create_tween()
	if timer.get_wait_time() == hidden_wait_time:
		timer.set_wait_time(wait_time)
		area.monitoring = true
		audio_player.play()
		await tween.tween_property(self, "scale", Vector2(max_scale, max_scale), duration).set_trans(Tween.TRANS_SPRING).finished
	else:
		timer.set_wait_time(hidden_wait_time)
		await tween.tween_property(self, "scale", Vector2(max_scale, 0.0), duration).set_trans(Tween.TRANS_SPRING).finished
		area.monitoring = false
	timer.start()


func _on_area_2d_area_entered(p_area: Area2D) -> void:
	if p_area.get_owner().is_in_group("player") && !hit:
		var player: PlayerController2D = p_area.get_owner()
		hit_player.play()
		player.on_hit()
		hit = true
		await get_tree().create_timer(0.3).timeout
		hit = false
