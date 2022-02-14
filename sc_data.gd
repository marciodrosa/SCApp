extends Resource
class_name SCData

# Array os strings with the names of the movies of the current SC.
var movies = []

# Array with SCPerson objects representing the people who participates the SC as voters or curator.
var people = []

# The index of the person in the people array that is the curator of the current SC.
var curator_index = 0

# The list of movies names separated by line.
var movies_as_string_list: String setget set_movies_as_string_list, get_movies_as_string_list

# Subset of the people list, without the curator.
var voters: Array setget , get_voters

func _init():
	people = [
		SCPerson.new("Felipe"),
		SCPerson.new("Júlia"),
		SCPerson.new("Márcio"),
		SCPerson.new("Rafa")
	]

func set_movies_as_string_list(string_list: String):
	movies = string_list.split("\n", false)
	
func get_movies_as_string_list() -> String:
	var result = ""
	for movie in movies:
		if result.length() > 0:
			result += "\n"
		result += movie
	return result

func get_voters() -> Array:
	var result = []
	for i in range(people.size()):
		if i != curator_index:
			result.append(people[i])
	return result
