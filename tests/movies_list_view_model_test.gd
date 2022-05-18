extends WATTest

var view_model: MoviesListViewModel
var app_state: SCAppState

func pre():
	app_state = SCAppState.new()
	app_state.data = SCData.new()
	app_state.data.movies = [
		"Matrix",
		"The Godfather",
		"Mad Max"
	]
	view_model = MoviesListViewModel.new(app_state)


func test_should_have_movies_list_as_string():
	asserts.is_equal(view_model.movies, "Matrix\nThe Godfather\nMad Max")


func test_should_update_movies_list():
	# when:
	view_model.movies = "Star Wars\nHarry Potter"
	asserts.is_equal(Array(app_state.data.movies), ["Star Wars", "Harry Potter"])


func test_be_able_to_go_next_if_there_are_movies():
	asserts.is_true(view_model.can_go_next)
	view_model.movies = ""
	asserts.is_false(view_model.can_go_next)
