## View model for the votes screen.
class_name VotesViewModel

class VoteViewModel:
	enum State { COMPLETED, ERROR, WARNING }
	var person_name = ""
	var votes = "" : set = _set_votes
	var penalty = 0 : set = _set_penalty
	var validated_movies = ""
	var are_votes_valid = false
	var error_message = ""
	var state: State = State.WARNING
	var _person: SCPerson : set = _set_person
	var _votes_service = SCVotesService.new()
	var _data_service = SCDataService.new()
	var _app_state: SCAppState
	
	
	func save():
		_data_service.save_data(_app_state.data)
	
	
	func _set_votes(v):
		votes = v
		_person.votes_as_string_list = v
		validated_movies = _votes_service.convert_person_votes_to_movies_list_string(_person.votes, _app_state.data.movies)
		var validation = _votes_service.validate_person_votes(_person.votes, _app_state.data.movies)
		are_votes_valid = validation.validated
		error_message = validation.message
		if votes == "":
			state = State.WARNING
		else:
			state = State.COMPLETED if are_votes_valid else State.ERROR
	
	
	func _set_penalty(p):
		penalty = p
		_person.penalty = p
	
	
	func _set_person(p):
		_person = p
		person_name = p.name
		self.votes = p.votes_as_string_list
		self.penalty = p.penalty
		

## Flag indicating if the user can go to next screen.
var can_go_next = false : get = _can_go_next

## Array of VoteViewModel objects to show.
var votes: Array

var _votes_service = SCVotesService.new()

var _data_service = SCDataService.new()

var _app_state: SCAppState


func _init(state: SCAppState):
	_app_state = state
	votes = []
	for person in _app_state.data.voters:
		var vote_view_model = VoteViewModel.new()
		vote_view_model._app_state = _app_state
		vote_view_model._votes_service = _votes_service
		vote_view_model._data_service = _data_service
		vote_view_model._person = person
		votes.append(vote_view_model)


func go_next() -> String:
	save()
	_app_state.result = _votes_service.calculate_result(_app_state.data)
	return "res://view/result_screen.tscn"


func go_back() -> String:
	save()
	return "res://view/movies_list_screen.tscn"


func save():
	_data_service.save_data(_app_state.data)


func _can_go_next() -> bool:
	for vote_view_model in votes:
		if vote_view_model.state == VoteViewModel.State.ERROR:
			return false
	return true
