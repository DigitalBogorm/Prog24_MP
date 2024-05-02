extends Node2D
 

@export var player_scene: PackedScene

var players = {}

var player_info = {"name": "Name"}

var players_loaded = 0
 
func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
 
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
 
 
func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	if $Menu/LineEdit.text != "":
		var adress = $Menu/LineEdit.text
		peer.create_client(adress, 135)
		multiplayer.multiplayer_peer = peer
	else:
		$Menu/LineEdit.placeholder_text = "Please write an adress"

	
 
func _on_player_connected(id):
	_register_player.rpc_id(id, player_info)

@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info

func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	

