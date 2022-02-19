extends Control


func _ready():
	var scroll_v_box = $VBoxContainer/MarginContainer/ScrollContainer/ScrollVBox
	for person in AppState.data.voters:
		var person_votes_control = preload("res://scenes/person_votes.tscn").instance()
		person_votes_control.person = person
		scroll_v_box.add_child(person_votes_control)


func _on_Footer_on_back():
	SCDataIO.new().save_data(AppState.data)
	get_tree().change_scene("res://scenes/movies_list_screen.tscn")


func _on_Footer_on_next():
	SCDataIO.new().save_data(AppState.data)
	AppState.result = SCVotesCalculator.new().calculate_result(AppState.data)
	get_tree().change_scene("res://scenes/result_screen.tscn")
