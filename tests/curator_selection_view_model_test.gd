extends TestCase

var view_model: CuratorSelectionViewModel
var app_state: SCAppState

func pre():
	app_state = SCAppState.new()
	app_state.data = SCData.new()
	app_state.data.people = [
		SCPerson.new("John"),
		SCPerson.new("Paul"),
		SCPerson.new("Ringo")
	]
	view_model = CuratorSelectionViewModel.new(app_state)


func test_should_have_curators_list():
	asserts.is_equal(view_model.curators_list, ["Selecione...", "John", "Paul", "Ringo"])
