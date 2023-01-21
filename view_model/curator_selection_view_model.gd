extends RefCounted

# View model for the curator selection screen.
class_name CuratorSelectionViewModel

# Flag indicating if the user can go to next screen.
var can_go_next = false : get = _can_go_next

# Array of String objects to show.
var curators_list: Array : get = _get_curators_list

# The selected index of the curators_list array.
var curators_list_selected_index: int = 0

var _data_service = SCDataService.new()

var _app_state: SCAppState


func _init(state: SCAppState):
	_app_state = state


func ready():
	_app_state.data = _data_service.load_data()
	curators_list_selected_index = _app_state.data.curator_index + 1


func go_next() -> String:
	_app_state.data.curator_index = curators_list_selected_index - 1
	_data_service.save_data(_app_state.data)
	return "res://view/movies_list_screen.tscn"


func _can_go_next() -> bool:
	var is_none_selected = curators_list_selected_index == 0
	return !is_none_selected


func _get_curators_list() -> Array:
	var result = ["Selecione..."]
	for person in _app_state.data.people:
		result.append(person.name)
	return result
