extends Control


func _ready():
	$VBoxContainer/MarginContainer/VBoxContainer/ResultText.text = AppState.result.to_string()


func _on_Footer_on_back():
	get_tree().change_scene("res://view/votes_screen.tscn")
