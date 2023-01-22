extends PanelContainer

@export
var back_button_enabled = true:
	set(value):
		back_button_enabled = value
		refresh_buttons()

@export
var next_button_enabled = true:
	set(value):
		next_button_enabled = value
		refresh_buttons()

signal on_next

signal on_back

signal on_save


func _ready():
	refresh_buttons()


func refresh_buttons():
	get_node("%BackButton").disabled = not back_button_enabled
	get_node("%NextButton").disabled = not next_button_enabled


func _on_save_button_pressed():
	on_save.emit()


func _on_back_button_pressed():
	on_back.emit()


func _on_next_button_pressed():
	on_next.emit()
