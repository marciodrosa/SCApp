extends Resource
class_name SCData

# Array os strings with the names of the movies of the current SC.
var movies = []

# Array with SCPerson objects representing the people who is voting.
var voters = []

# The current curator of the SC.
var curator: SCPerson

func _init():
	voters.append(SCPerson.new("Felipe"))
	voters.append(SCPerson.new("Júlia"))
	voters.append(SCPerson.new("Márcio"))
	voters.append(SCPerson.new("Rafa"))
