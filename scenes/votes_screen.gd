extends Control


func _ready():
	var scroll_v_box = $VBoxContainer/MarginContainer/ScrollContainer/ScrollVBox
	for person in AppState.data.voters:
		var person_votes_control = preload("res://scenes/person_votes.tscn").instance()
		person_votes_control.person = person
		scroll_v_box.add_child(person_votes_control)
