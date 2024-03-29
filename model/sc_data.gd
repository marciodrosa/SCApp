extends RefCounted

# This is the object that stores all SC related data. This is also the object that is serialized to
# save and load the data.
class_name SCData

# Array os strings with the names of the movies of the current SC.
var movies = []

# Array with SCPerson objects representing the people who participates the SC as voters or curator.
var people = []

# The index of the person in the people array that is the curator of the current SC.
var curator_index = 0

# The list of movies names separated by line.
var movies_as_string_list: String : get = get_movies_as_string_list, set = set_movies_as_string_list

# Subset of the people list, without the curator.
var voters: Array : get = get_voters

func _init():
	people = [
		SCPerson.new("Felipe"),
		SCPerson.new("Júlia"),
		SCPerson.new("Márcio"),
		SCPerson.new("Rafa")
	]
	curator_index = -1


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


# Converts this object into a dictionary that can be serialized.
func to_dictionary() -> Dictionary:
	var array_of_people_dictionaries = []
	for person in people:
		array_of_people_dictionaries.append({
			"name": person.name,
			"penalty": person.penalty,
			"votes_as_string_list": person.votes_as_string_list
		})
	return {
		"curator_index": self.curator_index,
		"movies_as_string_list": self.movies_as_string_list,
		"people": array_of_people_dictionaries
	}


# Oposite version of to_dictionary, reads the properties from a dictionary.
func from_dictionary(dictionary: Dictionary):
	self.people = []
	for person_dictionary in dictionary.get("people", {}):
		var person = SCPerson.new(person_dictionary.get("name", ""))
		person.penalty = person_dictionary.get("penalty", 0)
		person.votes_as_string_list = person_dictionary.get("votes_as_string_list", "")
		self.people.append(person)
	self.curator_index = dictionary.get("curator_index", 0)
	self.movies_as_string_list = dictionary.get("movies_as_string_list", "")
