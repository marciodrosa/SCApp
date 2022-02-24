extends Control


# The person to show and manage the votes.
var person: SCPerson


var _is_dragging_vote = false


func _gui_input(event):
	if event is InputEventMouseMotion and _is_dragging_vote:
		var vote_position = _get_new_vote_position(event.get_position().y)
		var container = $MarginContainer/VBoxContainer
		var each_vote_space = container.rect_size.y / container.get_child_count()
		var y = vote_position * each_vote_space
		y -= 2
		y += 8
		var rectangle = $Control/DragRectangle
		rectangle.rect_position.y = y
		rectangle.visible = true


func _vote_drag_started(control: Control):
	_is_dragging_vote = true


func _vote_drag_ended(control: Control):
	_is_dragging_vote = false
	$Control/DragRectangle.visible = false


func _ready():
	var container = $MarginContainer/VBoxContainer
	for i in range(person.votes.size()):
		var vote_entry = preload("res://scenes/vote_entry.tscn").instance()
		vote_entry.person = person
		vote_entry.vote_index = i
		vote_entry.connect("vote_drag_started", self, "_vote_drag_started")
		vote_entry.connect("vote_drag_ended", self, "_vote_drag_ended")
		container.add_child(vote_entry)
		vote_entry.set_drag_forwarding(self)


func _refresh_votes_controls():
	var container = $MarginContainer/VBoxContainer
	for i in range(container.get_child_count()):
		var vote_entry = container.get_child(i)
		vote_entry.vote_index = i


func _get_new_vote_position(y: int):
	var container = $MarginContainer/VBoxContainer
	var each_vote_space = container.rect_size.y as int / container.get_child_count()
	var vote_index_at_y = (y / each_vote_space) as int
	var relative_y = y % each_vote_space
	return vote_index_at_y if relative_y < (each_vote_space / 2) else vote_index_at_y + 1


func drop_data(position, data):
	var new_index_of_dropped_movie = _get_new_vote_position(position.y)
	var old_index_of_dropped_movie = data.vote_index
	person.move_vote_to_position(old_index_of_dropped_movie, new_index_of_dropped_movie)
	_refresh_votes_controls()


func drop_data_fw(position, data, from_control):
	drop_data(position + from_control.rect_position, data)


func can_drop_data(position, data):
	var container = $MarginContainer/VBoxContainer
	return data is Control and data.get_parent_control() == container


func can_drop_data_fw(position, data, from_control):
	return can_drop_data(position, data)


func get_drag_data_fw(position, from_control):
	var preview_control = preload("res://scenes/vote_entry.tscn").instance()
	preview_control.person = person
	preview_control.vote_index = from_control.vote_index
	set_drag_preview(preview_control)
	preview_control.rect_size = from_control.rect_size
	return from_control
