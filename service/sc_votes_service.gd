extends Reference
# Object responsible to calculate the results of a SC.
class_name SCVotesService


# Generates the result of the votes using the given data.
func calculate_result(data: SCData) -> SCResult:
	var result = SCResult.new()
	result.voters = data.voters
	result.votes = calculate_votes_of_people(data.voters, data)
	result.movies_sorted_by_votes = get_movies_sorted_by_votes(result.votes)
	var best_number_of_votes = 0
	for movie in result.movies_sorted_by_votes:
		var movie_votes = result.votes[movie]
		if movie_votes >= best_number_of_votes:
			best_number_of_votes = movie_votes
			result.choosen_movies.append(movie)
	result.tie = result.choosen_movies.size() > 1
	return result


# Returns the number of points the movie should receive given the position in the list of a person
# (starting from 0), the total number of movies that is available to vote, and the penalty the person
# has.
func convert_vote_to_points(vote_position: int, number_of_movies: int, penalty = 0) -> int:
	var result = number_of_movies - vote_position
	if penalty > 0:
		var adjusted_penalty = clamp(penalty - vote_position, 0, penalty)
		result -= adjusted_penalty
	return clamp(result, 1, number_of_movies) as int


# Returns a dictionary with the votes of the given person, where the keys are the name of the movies
# and the values are the amount of votes (points) the movie had.
func calculate_votes_of_a_person(person: SCPerson, data: SCData) -> Dictionary:
	var person_movies = convert_person_votes_to_movies_list(person.votes, data.movies)
	var result = {}
	for i in range(person_movies.size()):
		var movie = person_movies[i]
		var vote_points = convert_vote_to_points(i, person_movies.size(), person.penalty)
		result[movie] = vote_points
	return result


# Returns a new dictionary where the key is the name of the movie and the value is the number of votes
# by joining two given dictionaries (it is assumed they have the same keys).
func join_votes(votes1: Dictionary, votes2: Dictionary) -> Dictionary:
	var result = {}
	for movie in votes1:
		result[movie] = votes1[movie] + (votes2[movie] if votes2.has(movie) else 0)
	return result


# Returns a dictionary with the votes of all people in the given array of SCPerson objects, where the
# keys are the name of the movies and the values are the amount of votes (points) the movie had.
func calculate_votes_of_people(people: Array, data: SCData) -> Dictionary:
	var result = {}
	for person in people:
		result = join_votes(calculate_votes_of_a_person(person, data), result)
	return result


# Class used internally by the function get_movies_sorted_by_votes.
class _MovieSorter:
	var votes: Dictionary
	func sort(movie1, movie2) -> bool:
		return votes[movie1] > votes[movie2]


# Returns the list of movies names (array of strings) sorted by the number of votes, given a dictionary
# where the keys are the name of the movies and the values are the number of votes it has.
func get_movies_sorted_by_votes(votes: Dictionary) -> Array:
	var sorter = _MovieSorter.new()
	sorter.votes = votes
	var movies_list = votes.keys()
	movies_list.sort_custom(sorter, "sort")
	return movies_list


# Converts the votes of a person to the exact match of an available movie, using
# string similarity. The result can be smaller than the available movies list if
# some vote doesn't match at all of if the votes list size doesn't match. 
func convert_person_votes_to_movies_list(votes: Array, available_movies: Array) -> Array:
	var result = []
	for vote in votes:
		var biggest_similarity = 0.0
		var better_match = ""
		for available_movie in available_movies:
			var similarity = vote.to_upper().similarity(available_movie.to_upper())
			if similarity > biggest_similarity:
				biggest_similarity = similarity
				better_match = available_movie
		if biggest_similarity > 0.0:
			result.append(better_match)
	return result


# Similar to convert_person_votes_to_movies_list, but returns a String with one
# movie per line instead of an Array.
func convert_person_votes_to_movies_list_string(votes: Array, available_movies: Array) -> String:
	var movies = convert_person_votes_to_movies_list(votes, available_movies)
	var result = ""
	for movie in movies:
		if result.length() > 0:
			result += "\n"
		result += movie
	return result


# Returns a dictionary with a "validated" flag indicating if the votes are valid
# and a string "message" containing the error, if not validated.
func validate_person_votes(votes: Array, available_movies: Array) -> Dictionary:
	var converted_votes = convert_person_votes_to_movies_list(votes, available_movies)
	if votes.size() == 0:
		return {
			"validated": false,
			"message": "Põe os votos da pessoa ae."
		}
	if converted_votes.size() < available_movies.size():
		return {
			"validated": false,
			"message": "Parece que tem algo faltando: essa pessoa tem menos votos do que a quantidade de filmes disponíveis."
		}
	for movie in available_movies:
		var movie_votes_count = converted_votes.count(movie)
		if movie_votes_count > 1:
			return {
				"validated": false,
				"message": "O filme %s está sendo votado %d vezes." % [movie, movie_votes_count]
			}
	return {
		"validated": true,
		"message": ""
	}

