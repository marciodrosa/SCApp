extends TestCase

var data: SCData
var result: SCResult

func pre():
	data = SCData.new()
	result = SCResult.new()


func test_should_return_votes_by_movie_as_string():
	# given:
	result.votes = {
		"Bound": 9,
		"The Driller Killer": 4,
		"Bad Lieutenant": 5
	}
	result.movies_sorted_by_votes = ["Bound", "Bad Lieutenant", "The Driller Killer"]
	
	# when:
	var string_result = result.votes_by_movie_to_string()
	
	# then:
	asserts.is_equal(string_result, "1 - Bound: 9 votos\n2 - Bad Lieutenant: 5 votos\n3 - The Driller Killer: 4 votos")


func test_should_return_votes_by_movie_as_string_with_ties():
	# given:
	result.votes = {
		"Bound": 5,
		"The Driller Killer": 4,
		"Bad Lieutenant": 5,
		"Matrix": 4,
		"The Ambulance": 2,
	}
	result.movies_sorted_by_votes = ["Bound", "Bad Lieutenant", "The Driller Killer", "Matrix", "The Ambulance"]
	
	# when:
	var string_result = result.votes_by_movie_to_string()
	
	# then:
	asserts.is_equal(string_result, "1 - Bound: 5 votos\n1 - Bad Lieutenant: 5 votos\n3 - The Driller Killer: 4 votos\n3 - Matrix: 4 votos\n5 - The Ambulance: 2 votos")


func test_should_return_string_description():
	# given:
	result.choosen_movies = ["Bound"]
	result.tie = false
	result.votes = {
		"Bound": 9,
		"The Driller Killer": 4,
		"Bad Lieutenant": 5
	}
	result.movies_sorted_by_votes = ["Bound", "Bad Lieutenant", "The Driller Killer"]
	result.voters = [
		SCPerson.new("Felipe"),
		SCPerson.new("Júlia"),
		SCPerson.new("Rafa"),
	]
	result.voters[0].votes = ["Bound", "Bad Lieutenant", "The Driller Killer"]
	result.voters[1].votes = ["Bound", "Bad Lieutenant", "The Driller Killer"]
	result.voters[2].votes = ["Bound", "The Driller Killer", "Bad Lieutenant"]
	
	# when:
	var result_as_string = result.to_string()
	
	# then:
	asserts.is_equal(result_as_string, """*HABEMUS FILME*!

E o filme é...
*BOUND*

Votos por filme:

1 - Bound: 9 votos
2 - Bad Lieutenant: 5 votos
3 - The Driller Killer: 4 votos

Votos por pessoa:

Felipe:
Bound
Bad Lieutenant
The Driller Killer

Júlia:
Bound
Bad Lieutenant
The Driller Killer

Rafa:
Bound
The Driller Killer
Bad Lieutenant""")


func test_should_return_string_description_with_a_tie():
	# given:
	result.choosen_movies = ["Bound", "Bad Lieutenant"]
	result.tie = true
	result.votes = {
		"Bound": 5,
		"The Driller Killer": 4,
		"Bad Lieutenant": 5
	}
	result.movies_sorted_by_votes = ["Bound", "Bad Lieutenant", "The Driller Killer"]
	result.voters = [
		SCPerson.new("Felipe"),
		SCPerson.new("Júlia"),
		SCPerson.new("Rafa"),
	]
	
	# when:
	var result_as_string = result.to_string()
	
	# then:
	asserts.string_begins_with("HABEMUS *EMPATE*!\n\nFilmes empatados:\nBound\nBad Lieutenant\n", result_as_string)
