extends TouchScreenButton

class_name SwipeScreenButton

var on_area:bool = false


func _ready():
	self.pressed.connect(_on_pressed)
	self.released.connect(_on_released)
	self.shape.size = get_window().size as Vector2
	self.position = get_window().size * 0.5


func get_swipe_direction(swipe, swipe_margin) -> Vector2:
	var swipe_direction: Vector2 = Vector2.ZERO
	
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y >= swipe_margin:
		swipe_direction = Vector2.DOWN

	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y <= -swipe_margin:
		swipe_direction = Vector2.UP
	
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x >= swipe_margin:
		swipe_direction = Vector2.RIGHT
	
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x <= -swipe_margin:
		swipe_direction = Vector2.LEFT
	
	if on_area == true:
		return swipe_direction
	return Vector2.ZERO

func _on_pressed() -> void:
	on_area = true


func _on_released() -> void:
	on_area = false
