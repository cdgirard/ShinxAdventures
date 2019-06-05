extends Node


onready var World = preload("res://World.tscn")
#onready var Shinx = preload("res://objs//Shinx.tscn")
#For Testing Only
onready var Ball = preload("res://objs//Ball.tscn")
onready var Hammer = preload("res://objs//Hammer.tscn")
onready var ArmAnim = preload("res://ArmAnimation.tscn")


var world
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = Shinx.instance()
	var armA = ArmAnim.instance()
	armA.position = Vector2(600,800)
	add_child(armA)
	var blockLoc = Vector2(600,950)
	Shinx.position = blockLoc
	add_child(Shinx)
	world = World.instance()
	add_child(world)
	#Only for testing the objects
	var ball = Ball.instance()
	var ballLoc = Vector2(800,950)
	ball.position = ballLoc
	add_child(ball)
	var hammer = Hammer.instance()
	var hammerLoc = Vector2(500,950)
	hammer.position = hammerLoc
	add_child(hammer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
