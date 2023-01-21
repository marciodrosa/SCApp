extends Control


@export var back_button_enabled = true : set = set_back_button_enabled

@export var next_button_enabled = true : set = set_next_button_enabled

signal on_next

signal on_back


func _ready():
	refresh_buttons()


func _on_BackButton_pressed():
	emit_signal("on_back")


func _on_NextButton_pressed():
	emit_signal("on_next")


func set_back_button_enabled(enabled):
	back_button_enabled = enabled
	refresh_buttons()
	pass


func set_next_button_enabled(enabled):
	next_button_enabled = enabled
	refresh_buttons()
	pass


func refresh_buttons():
	$MarginContainer/HBoxContainer/BackButton.disabled = not back_button_enabled
	$MarginContainer/HBoxContainer/NextButton.disabled = not next_button_enabled
