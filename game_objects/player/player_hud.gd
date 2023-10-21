extends Control

@export var timer_on:bool = true
@onready var timer_label:Label = $%TimerLabel
var timer: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_on:
		timer += delta
	var mills:float = fmod(timer, 1) * 1000
	var seconds:float = fmod(timer, 60)
	var minutes:float = fmod(timer, 60 * 60) / 60
	timer_label.text = "%02d : %02d : %03d" %[minutes, seconds, mills]
