extends Node


onready var Door = preload("res://Door.tscn")
onready var EmptyFloor = preload("res://EmptyFloor.tscn")
onready var Shinx = preload("res://Shinx.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for loc in range(10) :
		if (loc == 5) :
			var doorLoc = Vector2(50*loc,100)
			var door = Door.instance()
			door.position = doorLoc
			add_child(door)
		else :
			var blockLoc = Vector2(50*loc,100)
			var emptyFloor = EmptyFloor.instance()
			emptyFloor.position = blockLoc
			add_child(emptyFloor)
	
	var player = Shinx.instance()
	var playerLoc = Vector2(200,50)
	player.position = playerLoc
	add_child(player)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
