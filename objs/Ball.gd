extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	print("called")
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click()

func on_click():
    print("Click")

#func _input(event):
   # Mouse in viewport coordinates
 #  if event is InputEventMouseButton:
  #     print("Mouse Click/Unclick at: ", event.position)
  # elif event is InputEventMouseMotion:
   #    print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   #print("Viewport Resolution is: ", get_viewport_rect().size)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
