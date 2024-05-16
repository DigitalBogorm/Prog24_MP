extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Arena1").enabled = false
	get_node("TileMapTest").enabled = false
	print(randi() % 3)

	if randi() == 1:
		$Arena1.visible = true
		get_node("Arena1").enabled = true
	else: 
		$TileMapTest.visible = true
		get_node("TileMapTest").enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
