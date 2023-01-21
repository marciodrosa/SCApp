extends Control

var view_model: MoviesListViewModel


func _ready():
	view_model = MoviesListViewModel.new(AppState)
	var movies_text_edit = $Panel/VBoxContainer/MarginContainer/VBoxContainer/MoviesListTextEdit
	movies_text_edit.text = view_model.movies
	check_next_button_availability()


func check_next_button_availability():
	var footer = $Panel/VBoxContainer/Footer
	footer.next_button_enabled = view_model.can_go_next


func _on_MoviesListTextEdit_text_changed():
	var movies_text_edit = $Panel/VBoxContainer/MarginContainer/VBoxContainer/MoviesListTextEdit
	view_model.movies = movies_text_edit.text
	check_next_button_availability()


func _on_Footer_on_back():
	get_tree().change_scene_to_file(view_model.go_back())


func _on_Footer_on_next():
	get_tree().change_scene_to_file(view_model.go_next())
