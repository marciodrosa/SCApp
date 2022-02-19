extends Node

# Singleton node with the main state of the app.
class_name SCAppState

# The current data of the SC selection and votes.
var data: SCData

# The results of the votes.
var result: SCResult


func _ready():
	data = SCData.new()
