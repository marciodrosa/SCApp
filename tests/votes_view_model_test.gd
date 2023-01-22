extends TestCase

var view_model: VotesViewModel
var app_state: SCAppState

func pre():
	app_state = SCAppState.new()
	app_state.data = SCData.new()
	app_state.data.movies = ["Matrix", "Mad Max", "The Godfather"]
	app_state.data.people = [SCPerson.new("John"), SCPerson.new("Paul"), SCPerson.new("George")]
	app_state.data.curator_index = 2
	app_state.data.voters[0].penalty = 3
	app_state.data.voters[0].votes = ["The Godfather", "Matrix", "Mad Max"]
	app_state.data.voters[1].votes = ["Matrix", "The Godfather", "Mad Max"]
	view_model = VotesViewModel.new(app_state)


func test_should_init_with_given_state():
	asserts.is_true(view_model.can_go_next)
	asserts.is_equal(view_model.votes.size(), 2)
	asserts.is_equal(view_model.votes[0].person_name, "John")
	asserts.is_equal(view_model.votes[0].votes, "The Godfather\nMatrix\nMad Max")
	asserts.is_equal(view_model.votes[0].penalty, 3)
	asserts.is_equal(view_model.votes[0].validated_movies, "The Godfather\nMatrix\nMad Max")
	asserts.is_true(view_model.votes[0].are_votes_valid)
	asserts.is_equal(view_model.votes[1].person_name, "Paul")
	asserts.is_equal(view_model.votes[1].votes, "Matrix\nThe Godfather\nMad Max")
	asserts.is_equal(view_model.votes[1].penalty, 0)
	asserts.is_equal(view_model.votes[1].validated_movies, "Matrix\nThe Godfather\nMad Max")
	asserts.is_true(view_model.votes[1].are_votes_valid)


func test_should_not_validate_if_missing_a_vote():
	# given:
	view_model.votes[0].votes = "The Godfather\nMatrix"
	
	# then:
	asserts.is_equal(view_model.votes[0].validated_movies, "The Godfather\nMatrix")
	asserts.is_false(view_model.votes[0].are_votes_valid)
	asserts.is_equal(view_model.votes[0].error_message, "Parece que o(s) seguinte(s) filme(s) está(ão) faltando: Mad Max")
	asserts.is_false(view_model.can_go_next)
