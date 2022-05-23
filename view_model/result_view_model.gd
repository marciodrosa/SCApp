extends Reference

# View model for the results screen.
class_name ResultViewModel

# The result of the votes.
var result = ""

var _data_service = SCDataService.new()

var _app_state: SCAppState


func _init(state: SCAppState):
	_app_state = state
	result = _app_state.result.to_string()


func go_back() -> String:
	return "res://view/votes_screen.tscn"
