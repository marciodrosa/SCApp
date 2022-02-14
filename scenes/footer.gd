extends Control


export var back_button_enabled = true

export var next_button_enabled = true

signal on_next

signal on_back


func _ready():
	$MarginContainer/HBoxContainer/BackButton.disabled = not back_button_enabled
	$MarginContainer/HBoxContainer/NextButton.disabled = not next_button_enabled


func _on_BackButton_pressed():
	emit_signal("on_back")


func _on_NextButton_pressed():
	emit_signal("on_next")
