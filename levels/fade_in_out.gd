extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@export var fade_duration: float = 1.25
@export var music_player: AudioStreamPlayer = null
@export var next_level: PackedScene = null

@onready var player: PlayerController2D = get_tree().get_nodes_in_group("player")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.can_move = false
	player.on_level_finished.connect(_level_finished)
	color_rect.color = Color(0,0,0,1)
	if music_player: 
		music_player.play()
	await get_tree().create_timer(0.5).timeout
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(color_rect, "color", Color(0,0,0,0), fade_duration).set_trans(Tween.TRANS_LINEAR)
	player.can_move = true

func _level_finished() -> void:
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(color_rect, "color", Color(0,0,0,1), fade_duration).set_trans(Tween.TRANS_LINEAR)
	if music_player:
		tween.tween_property(music_player, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	if next_level:
		get_tree().change_scene_to_packed(next_level)
