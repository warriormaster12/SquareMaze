extends Node2D
class_name PlayerController2D

@export var speed:float = 300
@export var ray_length: float = 1000

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var ray_down: RayCast2D = $DownRay
@onready var ray_up: RayCast2D = $UpRay
@onready var ray_left: RayCast2D = $LeftRay
@onready var ray_right: RayCast2D = $RightRay
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
var stop_moving: bool = false

var move_tween: Tween = null
var last_pos: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

var selected_ray:RayCast2D = null
var can_move: bool = true

func _ready() -> void:
	ray_down.target_position *= (player_sprite.texture.get_width() * 0.5)
	ray_up.target_position *= (player_sprite.texture.get_width() * 0.5)
	ray_left.target_position *= (player_sprite.texture.get_width() * 0.5)
	ray_right.target_position *= (player_sprite.texture.get_width() * 0.5)

func _process(_delta: float) -> void:
	if selected_ray:
		if selected_ray.is_colliding():
			var next_pos: Vector2 = selected_ray.get_collision_point() + selected_ray.get_collision_normal() * (player_sprite.texture.get_width() * 0.5)
			global_position = next_pos
			direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if direction.length() == 0 && can_move:
		if Input.is_action_just_pressed("move_r"):
			if !ray_right.is_colliding():
				audio_player.play()
				direction.x = 1
				last_pos = global_position
				selected_ray = ray_right
		if Input.is_action_just_pressed("move_l"):
			if !ray_left.is_colliding():
				audio_player.play()
				direction.x = -1
				last_pos = global_position
				selected_ray = ray_left
		if Input.is_action_just_pressed("move_u"):
			if !ray_up.is_colliding():
				audio_player.play()
				direction.y = -1
				last_pos = global_position
				selected_ray = ray_up
		if Input.is_action_just_pressed("move_d"):
			if !ray_down.is_colliding():
				audio_player.play()
				direction.y = 1
				last_pos = global_position
				selected_ray = ray_down
	
	global_position += direction * speed * delta

func on_hit() -> void:
	direction = Vector2.ZERO
	can_move = false
	anim_player.play("hit")
	await anim_player.animation_finished
	anim_player.play_backwards("hit")
	global_position = last_pos
	await anim_player.animation_finished
	can_move = true
