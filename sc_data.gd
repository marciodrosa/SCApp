extends Resource
class_name SCData

# Array os strings with the names of the movies of the current SC.
var movies = []

# Array with SCPerson objects representing the people who is voting.
var voters = []

# The current curator of the SC.
var curator: SCPerson

var movies_as_string_list: String setget set_movies_as_string_list, get_movies_as_string_list

func _init():
	voters.append(SCPerson.new("Felipe"))
	voters.append(SCPerson.new("Júlia"))
	voters.append(SCPerson.new("Márcio"))
	voters.append(SCPerson.new("Rafa"))

func set_movies_as_string_list(string_list: String):
	movies = string_list.split("\n", false)
	
func get_movies_as_string_list() -> String:
	var result = ""
	for movie in movies:
		if result.length() > 0:
			result += "\n"
		result += movie
	return result
