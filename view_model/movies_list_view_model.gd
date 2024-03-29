extends RefCounted

# View model for the movies list screen.
class_name MoviesListViewModel

# The movies input value.
var movies = "" : set = _set_movies

# Flag indicating if the user can go to next screen.
var can_go_next = false : get = _can_go_next

var _data_service = SCDataService.new()

var _app_state: SCAppState


func _init(state: SCAppState):
	_app_state = state
	movies = _app_state.data.movies_as_string_list


func go_next() -> String:
	save()
	return "res://view/votes_screen.tscn"


func go_back() -> String:
	save()
	return "res://view/curator_selection_screen.tscn"


func save():
	_data_service.save_data(_app_state.data)


func _can_go_next() -> bool:
	return _app_state.data.movies.size() > 0


func _set_movies(m: String):
	movies = m
	_app_state.data.movies_as_string_list = movies
