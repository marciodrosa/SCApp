@tool
extends Node

const IPAddress: String = "127.0.0.1"
const PORT: int = 6019
const MAXCLIENTS: int = 1
const MASTER: int = 1
var _peer: ENetMultiplayerPeer
var _id: int

func _init():
	_close()
	custom_multiplayer = MultiplayerAPI.new()
	custom_multiplayer.root_node = self
	custom_multiplayer.allow_object_decoding = true
	_peer = ENetMultiplayerPeer.new()
	
func _process(delta: float) -> void:
	if custom_multiplayer.has_multiplayer_peer():
		custom_multiplayer.poll()

func _close() -> void:
	if is_instance_valid(_peer):
		if _is_connected():
			_peer.close_connection()
		_peer = null
		
func _error(err: int) -> int:
	if err != OK:
		match err:
			ERR_ALREADY_IN_USE:
				push_warning("Network Peer is already in use")
			ERR_CANT_CREATE:
				push_warning("Network Peer cannot be created")
			_:
				push_warning(err as String)
	return err
	
func _is_connected() -> bool:
	return _peer.get_connection_status() == ENetMultiplayerPeer.CONNECTION_CONNECTED

func _exit_tree() -> void:
	_close()
