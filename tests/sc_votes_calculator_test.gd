extends WATTest

var calculator: SCVotesCalculator
var person: SCPerson

func pre():
	calculator = SCVotesCalculator.new()
	person = SCPerson.new()


func test_should_convert_vote_to_points():
	asserts.is_equal(calculator.convert_vote_to_points(0, 7), 7)
	asserts.is_equal(calculator.convert_vote_to_points(1, 7), 6)
	asserts.is_equal(calculator.convert_vote_to_points(2, 7), 5)
	asserts.is_equal(calculator.convert_vote_to_points(3, 7), 4)
	asserts.is_equal(calculator.convert_vote_to_points(4, 7), 3)
	asserts.is_equal(calculator.convert_vote_to_points(5, 7), 2)
	asserts.is_equal(calculator.convert_vote_to_points(6, 7), 1)


func test_should_convert_vote_to_points_with_penalty():
	asserts.is_equal(calculator.convert_vote_to_points(0, 7, 2), 5)
	asserts.is_equal(calculator.convert_vote_to_points(1, 7, 2), 5)
	asserts.is_equal(calculator.convert_vote_to_points(2, 7, 2), 5)
	asserts.is_equal(calculator.convert_vote_to_points(3, 7, 2), 4)
	asserts.is_equal(calculator.convert_vote_to_points(4, 7, 2), 3)
	asserts.is_equal(calculator.convert_vote_to_points(5, 7, 2), 2)
	asserts.is_equal(calculator.convert_vote_to_points(6, 7, 2), 1)


func test_should_calculate_votes_of_a_person():
	# given:
	person.votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	
	# when:
	var result = calculator.calculate_votes_of_a_person(person)
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result["Bound"], 3)
	asserts.is_equal(result["Cría Cuervos"], 2)
	asserts.is_equal(result["Bad Luck Banging or Loony Porn"], 1)


func test_should_calculate_votes_of_a_person_with_penalty():
	# given:
	person.votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	person.penalty = 1
	
	# when:
	var result = calculator.calculate_votes_of_a_person(person)
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result["Bound"], 2)
	asserts.is_equal(result["Cría Cuervos"], 2)
	asserts.is_equal(result["Bad Luck Banging or Loony Porn"], 1)


func test_should_join_votes():
	# given:
	var dictionary1 = {
		"Bound": 3,
		"Cría Cuervos": 2,
		"Bad Luck Banging or Loony Porn": 1,
	}
	var dictionary2 = {
		"Bound": 5,
		"Cría Cuervos": 2,
		"Bad Luck Banging or Loony Porn": 4,
	}
	
	# when:
	var result = calculator.join_votes(dictionary1, dictionary2)
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result["Bound"], 8)
	asserts.is_equal(result["Cría Cuervos"], 4)
	asserts.is_equal(result["Bad Luck Banging or Loony Porn"], 5)


func test_should_calculate_votes_of_people():
	# given:
	var person1 = SCPerson.new()
	person1.votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	
	var person2 = SCPerson.new()
	person2.votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	person2.penalty = 1
	
	var person3 = SCPerson.new()
	person3.votes = ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"]
	
	# when:
	var result = calculator.calculate_votes_of_people([person1, person2, person3])
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result["Bound"], 7)
	asserts.is_equal(result["Cría Cuervos"], 5)
	asserts.is_equal(result["Bad Luck Banging or Loony Porn"], 5)


func test_should_get_movies_sorted_by_votes():
	# given:
	var votes = {
		"Bound": 3,
		"Cría Cuervos": 5,
		"Bad Luck Banging or Loony Porn": 4
	}
	
	# when:
	var result = calculator.get_movies_sorted_by_votes(votes)
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result[0], "Cría Cuervos")
	asserts.is_equal(result[1], "Bad Luck Banging or Loony Porn")
	asserts.is_equal(result[2], "Bound")


func test_should_calculate_result():
	# given:
	var data = SCData.new()
	data.people = [
		SCPerson.new("Felipe"),
		SCPerson.new("Júlia"),
		SCPerson.new("Márcio"),
		SCPerson.new("Rafa")
	]
	data.curator_index = 0
	data.voters[0].votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	data.voters[1].votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	data.voters[2].votes = ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"]
	
	# when:
	var result = calculator.calculate_result(data)
	
	# then:
	asserts.is_equal(result.choosen_movies.size(), 1)
	asserts.is_equal(result.choosen_movies[0], "Bound")
	asserts.is_false(result.tie)
	asserts.is_equal(result.votes.size(), 3)
	asserts.is_equal(result.votes["Bound"], 8)
	asserts.is_equal(result.votes["Cría Cuervos"], 5)
	asserts.is_equal(result.votes["Bad Luck Banging or Loony Porn"], 5)
	asserts.is_equal(result.movies_sorted_by_votes.size(), 3)
	asserts.is_equal(result.movies_sorted_by_votes[0], "Bound")
	asserts.is_equal(result.movies_sorted_by_votes[1], "Bad Luck Banging or Loony Porn")
	asserts.is_equal(result.movies_sorted_by_votes[2], "Cría Cuervos")
	asserts.is_equal(result.voters, data.voters)


func test_should_calculate_result_with_tie():
	# given:
	var data = SCData.new()
	data.people = [
		SCPerson.new("Felipe"),
		SCPerson.new("Júlia"),
		SCPerson.new("Márcio"),
		SCPerson.new("Rafa")
	]
	data.curator_index = 0
	data.voters[0].votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	data.voters[1].votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	data.voters[2].votes = ["Cría Cuervos", "Bad Luck Banging or Loony Porn", "Bound"]
	
	# when:
	var result = calculator.calculate_result(data)
	
	# then:
	asserts.is_equal(result.choosen_movies.size(), 2)
	asserts.is_true(result.choosen_movies.has("Bound"))
	asserts.is_true(result.choosen_movies.has("Cría Cuervos"))
	asserts.is_true(result.tie)
	asserts.is_equal(result.votes.size(), 3)
	asserts.is_equal(result.votes["Bound"], 7)
	asserts.is_equal(result.votes["Cría Cuervos"], 7)
	asserts.is_equal(result.votes["Bad Luck Banging or Loony Porn"], 4)
	asserts.is_equal(result.voters, data.voters)
