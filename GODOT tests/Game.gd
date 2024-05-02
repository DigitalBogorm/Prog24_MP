extends Node2D

var peer = ENetMultiplayerPeer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(preload("res://Menu.tscn").instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_host_pressed():
	peer.create_server(4)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	

func _add_player(id = 1):
	var player = preload("res://Player.tscn").instantiate()
	player.name = str(id)
	call_deferred("add_child", player)




func _on_join_pressed():
	peer.create_client("localhost", 4)
