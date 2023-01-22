extends Control

var view_model: ResultViewModel

func _ready():
	view_model = ResultViewModel.new(AppState)
	get_node("%ResultText").text = view_model.result


func _on_toolbar_on_back():
	get_tree().change_scene_to_file(view_model.go_back())


func _on_toolbar_on_save():
	pass
