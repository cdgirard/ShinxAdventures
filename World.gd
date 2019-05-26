extends Node

onready var WorldMap = preload("res://WorldMap.tscn")

onready var CeilingBlank = preload("res://objs/CeilingBlank.tscn")
onready var CeilingWithLight = preload("res://objs/CeilingWithLight.tscn")
onready var CeilingWithSideWall = preload("res://objs/CeilingWithSideWall.tscn")

onready var EmptyFloor = preload("res://objs/EmptyFloor.tscn")
onready var FloorWithSideDoor= preload("res://objs/FloorWithSideDoor.tscn")
onready var Door = preload("res://objs/Door.tscn")

var tileWidth = 54
var tileHeight = 98

var platform
var worldMap
var blocks = {}
var unusedEmptyFloor = []
var unusedDoor = []
var unusedFloorWithSideDoor = []
var unusedCeilingBlank = []
var unusedCeilingWithLight = []
var unusedCeilingWithSideWall = []
var buffer = 14 #How many blocks of the world to show around the player

# Called when the node enters the scene tree for the first time.
func _ready():
	#platform = Platform.instance()
	worldMap = WorldMap.instance()
	var info = worldMap.texture.get_data()
	update_map()
	
func update_map() :
	remove_blocks_outside_bounds()
	var info = worldMap.texture.get_data()
	info.lock()
	var pos = get_player()
	var bounds = compute_bounds()
	var imageStart = Vector2(pos.x/tileWidth,pos.y/tileHeight)
	var row = max(0,int(imageStart.y - buffer))
	
	while (row < info.get_height() and row  < int(imageStart.y + buffer)) :
		var col = max(0,int(imageStart.x - buffer))
		while (col < info.get_width() and col < int(imageStart.x + buffer)) :
			var blockLoc = Vector2(tileWidth*col,tileHeight*row)
			if (bounds.has_point(blockLoc) and !blocks.has(blockLoc)) :
				var colorInfo = info.get_pixel(col,row)
				var block = null
				var newBlock = true
				if colorInfo.r == 0 and colorInfo.g == 0 and colorInfo.b == 0 :
					if (unusedCeilingBlank.size() > 0):
						block = unusedCeilingBlank[0]
						unusedCeilingBlank.remove(0);
						newBlock = false
					else :
						block = CeilingBlank.instance()
				if colorInfo.r == 1 and colorInfo.g == 0 and colorInfo.b == 0 :
					if (unusedDoor.size() > 0):
						block = unusedDoor[0]
						unusedDoor.remove(0);
						newBlock = false
					else :
						block = Door.instance()
				if colorInfo.r == 0 and colorInfo.g == 1 and colorInfo.b == 0 :
					if (unusedEmptyFloor.size() > 0):
						block = unusedEmptyFloor[0]
						unusedEmptyFloor.remove(0);
						newBlock = false
					else :
						block = EmptyFloor.instance()
				if colorInfo.r == 1 and colorInfo.g == 1 and colorInfo.b == 0 :
					if (unusedFloorWithSideDoor.size() > 0):
						block = unusedFloorWithSideDoor[0]
						unusedFloorWithSideDoor.remove(0);
						newBlock = false
					else :
						block = FloorWithSideDoor.instance()
				if colorInfo.r == 0 and colorInfo.g == 0 and colorInfo.b == 1 :
					if (unusedCeilingWithLight.size() > 0):
						block = unusedCeilingWithLight[0]
						unusedCeilingWithLight.remove(0);
						newBlock = false
					else :
						block = CeilingWithLight.instance()
				if colorInfo.r == 0 and colorInfo.g == 1 and colorInfo.b == 1 :
					if (unusedCeilingWithSideWall.size() > 0):
						block = unusedCeilingWithSideWall[0]
						unusedCeilingWithSideWall.remove(0);
						newBlock = false
					else :
						block = CeilingWithSideWall.instance()
				if block != null :
					block.position = blockLoc
					blocks[block.position] = block
					
					if newBlock == true:
						add_child(block)
					else:
						block.show()
			col += 1
		row += 1
	info.unlock()

func get_player() :
	return Shinx.position

func compute_bounds() :
	var pos = get_player() #Location of the player, assumes it is child zero.
	var minPos = Vector2(pos.x-buffer*tileWidth,pos.y-buffer*tileHeight)
	var boundSize = Vector2(buffer*tileWidth*2,buffer*tileHeight*2)
	var bounds = Rect2(minPos,boundSize)
	return bounds

func remove_blocks_outside_bounds() :
	var bounds = compute_bounds()
	var removeList = {}
	for key in blocks :
		if (!bounds.has_point(key)) :
			#Really need to make sure the names are not subsets of each other.
			if (blocks[key].name.find("EmptyFloor")>-1):
				unusedEmptyFloor.append(blocks[key])
			elif (blocks[key].name.find("CeilingWithLight")>-1):
				unusedCeilingWithLight.append(blocks[key])
			elif (blocks[key].name.find("CeilingBlank")>-1):
				unusedCeilingBlank.append(blocks[key])
			elif (blocks[key].name.find("CeilingWithSideWall")>-1):
				unusedCeilingWithSideWall.append(blocks[key])
			elif (blocks[key].name.find("FloorWithSideDoor")>-1):
				unusedFloorWithSideDoor.append(blocks[key])
			elif (blocks[key].name.find("Door")>-1):
				unusedDoor.append(blocks[key])
			removeList[key] = blocks[key];
			
	for key in removeList :
		#remove_child(blocks[key])
		blocks[key].hide()
		blocks.erase(key)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_map()

