extends Node


onready var World = preload("res://World.tscn")
onready var Shinx = preload("res://objs//Shinx.tscn")


var world
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Shinx.instance()
	var blockLoc = Vector2(600,1000)
	player.position = blockLoc
	add_child(player)
	world = World.instance()
	add_child(world)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
