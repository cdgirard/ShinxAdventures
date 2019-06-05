extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Keeping this code for now, but likely removing from objects.
func old_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click(event.position)
		#print(Shinx.camera.get_camera_position()," : ",viewport.size)
		#print(to_global(position))
		
		var modX = event.position.x + Shinx.camera.get_camera_position().x - viewport.size.x/2
		var modY = event.position.y + Shinx.camera.get_camera_position().y - viewport.size.y/2
		#print(modX," : ",modY)
		var impulse = Vector2((position.x - modX)*5,(position.y - modY)*10)
		apply_central_impulse(impulse)
		

func on_click(pos):
	var xDiff = pos.x - position.x
	var yDiff = pos.y - position.y
	#print(pos, " : ",position)

#func _input(event):
#   # Mouse in viewport coordinates
#   if event is InputEventMouseButton:
#       print("Mouse Click/Unclick at: ", event.position)
  # elif event is InputEventMouseMotion:
   #    print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   #print("Viewport Resolution is: ", get_viewport_rect().size)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
