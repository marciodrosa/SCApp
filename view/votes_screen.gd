extends Control


func _ready():
	var scroll_v_box = $VBoxContainer/MarginContainer/ScrollContainer/ScrollVBox
	for person in AppState.data.voters:
		var person_votes_control = preload("res://view/person_votes.tscn").instance()
		person_votes_control.person = person
		scroll_v_box.add_child(person_votes_control)


func _on_Footer_on_back():
	SCDataService.new().save_data(AppState.data)
	get_tree().change_scene("res://view/movies_list_screen.tscn")


func _on_Footer_on_next():
	SCDataService.new().save_data(AppState.data)
	AppState.result = SCVotesService.new().calculate_result(AppState.data)
	get_tree().change_scene("res://view/result_screen.tscn")
