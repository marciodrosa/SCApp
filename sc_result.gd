extends Reference

# Contains data with the results of the votes.
class_name SCResult

# List of the names of the movies that have been choosen. Usually should be only one, but may be more
# in case of a tie.
var choosen_movies = []


# Flag indicating that the vote results in a tie between more than one movie. In this case,
# choosen_movies will have more than one element.
var tie = false


# Dictionary with the votes, where the key is the name of the movie and the value is the number of
# votes it had.
var votes = {}


# All movies names voted, sorted by the amount of votes each one had.
var movies_sorted_by_votes = []


# Array of the voters (SCPerson object).
var voters = []


# Returns a string representation of the votes each movie had.
func votes_by_movie_to_string() -> String:
	var result = ""
	var last_number_of_votes = 0
	var pos = 1
	for i in range(movies_sorted_by_votes.size()):
		var movie = movies_sorted_by_votes[i]
		var number_of_votes = votes[movie] if votes.has(movie) else 0
		if number_of_votes < last_number_of_votes or i == 0:
			pos = i + 1
			last_number_of_votes = number_of_votes
		if result.length() > 0:
			result += "\n"
		result += String(pos) + " - " + movie + ": " + String(number_of_votes) + " votos"
	return result


func _to_string() -> String:
	var result = ""
	if tie:
		result += "HABEMUS *EMPATE*!\n\nFilmes empatados:\n"
		for movie in choosen_movies:
			result += movie + "\n"
	else:
		result += "*HABEMUS FILME*!\n\nE o filme é...\n*" + choosen_movies[0].to_upper() + "*\n"
	result += "\nVotos por filme:\n\n" + votes_by_movie_to_string() + "\n"
	result += "\nVotos por pessoa:\n\n"
	var all_votes_of_all_voters = ""
	for person in voters:
		if all_votes_of_all_voters.length() > 0:
			all_votes_of_all_voters += "\n\n"
		all_votes_of_all_voters += person.votes_to_string()
	result += all_votes_of_all_voters
	return result
