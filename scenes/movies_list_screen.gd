extends Control


func _ready():
	var movies_text_edit = $Panel/VBoxContainer/MarginContainer/VBoxContainer/MoviesListTextEdit
	movies_text_edit.text = AppState.data.movies_as_string_list
	check_next_button_availability()


func check_next_button_availability():
	var footer = $Panel/VBoxContainer/Footer
	footer.next_button_enabled = AppState.data.movies.size() > 0


func _on_MoviesListTextEdit_text_changed():
	var movies_text_edit = $Panel/VBoxContainer/MarginContainer/VBoxContainer/MoviesListTextEdit
	AppState.data.movies_as_string_list = movies_text_edit.text
	for person in AppState.data.voters:
		person.votes = AppState.data.movies
	check_next_button_availability()


func _on_Footer_on_back():
	get_tree().change_scene("res://scenes/curator_selection_screen.tscn")


func _on_Footer_on_next():
	get_tree().change_scene("res://scenes/votes_screen.tscn")
