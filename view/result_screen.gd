extends Control

var view_model: ResultViewModel

func _ready():
	view_model = ResultViewModel.new(AppState)
	$VBoxContainer/MarginContainer/VBoxContainer/ResultText.text = view_model.result


func _on_Footer_on_back():
	get_tree().change_scene(view_model.go_back())
