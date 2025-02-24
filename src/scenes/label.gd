extends Label

var dragging = false
var offset = Vector2.ZERO

func _ready():
	# Ensure this node captures mouse input.
	set_mouse_filter(Control.MOUSE_FILTER_STOP)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				# Save the offset from the label's top-left to the mouse position.
				offset = event.position
			else:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		# Update the global position of the label based on the mouse movement.
		global_position = event.global_position - offset
