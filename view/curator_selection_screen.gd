extends Control


func _ready():
	AppState.data = SCDataService.new().load_data()
	var curators_list = $VBoxContainer/MarginContainer/VBoxContainer/CuratorsList
	curators_list.add_item("Selecione...")
	for person in AppState.data.people:
		curators_list.add_item(person.name)
	curators_list.select(AppState.data.curator_index + 1)
	check_next_button_availability()


func _on_Footer_on_next():
	var curators_list = $VBoxContainer/MarginContainer/VBoxContainer/CuratorsList
	AppState.data.curator_index = curators_list.get_selected_id() - 1
	SCDataService.new().save_data(AppState.data)
	get_tree().change_scene("res://view/movies_list_screen.tscn")


func check_next_button_availability():
	var curators_list = $VBoxContainer/MarginContainer/VBoxContainer/CuratorsList
	var selected_index = curators_list.get_selected_id()
	var is_none_selected = selected_index == 0
	var footer = $VBoxContainer/Footer
	footer.next_button_enabled = not is_none_selected


func _on_CuratorsList_item_selected(index):
	check_next_button_availability()
