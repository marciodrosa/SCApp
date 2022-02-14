extends Control


func _ready():
	var curators_list = $VBoxContainer/MarginContainer/VBoxContainer/CuratorsList
	for person in AppState.data.people:
		curators_list.add_item(person.name)
	curators_list.select(AppState.data.curator_index)



func _on_Footer_on_next():
	pass # Replace with function body.
