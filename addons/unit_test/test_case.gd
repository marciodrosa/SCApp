@tool
class_name TestCase
extends Node

var asserts
var direct
var p = null
var _params_index
var _parameters
var _registry


func _ready() -> void:
	asserts = preload("res://addons/unit_test/assertions/assertions.gd").new()
	direct = preload("res://addons/unit_test/double/factory.gd").new()
	_registry = preload("res://addons/unit_test/double/registry.gd").new()
	direct.registry = _registry
	add_child(direct)


func parameters(param: Array):
	if p == null:
		_parameters = param
		_params_index = 1
		_refresh_p()


func _refresh_p():
	if _parameters != null:
		p = {}
		var names = _parameters[0] as Array
		var values = _parameters[_params_index] as Array
		for i in names.size():
			p[names[i]] = values[i]


func pre():
	pass


func post():
	pass
