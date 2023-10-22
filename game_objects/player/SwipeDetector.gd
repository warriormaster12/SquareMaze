extends Node

@export var max_diagonal_slope: float = 1.3
@onready var timer: Timer = $Timer
var swipe_start_position: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

signal swiped(direction: Vector2)
signal swipe_cancelled(start_position: Vector2)

func _ready() -> void:
	timer.timeout.connect(_on_timeout)


func _input(event: InputEvent) -> void:
	if not event is InputEventScreenTouch:
		return
	if event.is_pressed():
		start_detection(event.position)
	elif not timer.is_stopped():
		end_detection(event.position)

func start_detection(position: Vector2) -> void:
	swipe_start_position = position
	timer.start()

func end_detection(position: Vector2) -> void:
	timer.stop()
	var direction:Vector2 = position.direction_to(swipe_start_position).normalized()
	if abs(direction.x) + abs(direction.y) >= max_diagonal_slope:
		return
	if abs(direction.x) > abs(direction.y):
		swiped.emit(Vector2(-sign(direction.x), 0.0))
	else: 
		swiped.emit(Vector2(0.0, -sign(direction.y)))

func _on_timeout() -> void:
	swipe_cancelled.emit(swipe_start_position)
