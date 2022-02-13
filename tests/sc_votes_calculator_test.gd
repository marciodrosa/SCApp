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
	person.votes.append("Bound")
	person.votes.append("Cría Cuervos")
	person.votes.append("Bad Luck Banging or Loony Porn")
	
	# when:
	var result = calculator.calculate_votes_of_a_person(person)
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result["Bound"], 3)
	asserts.is_equal(result["Cría Cuervos"], 2)
	asserts.is_equal(result["Bad Luck Banging or Loony Porn"], 1)

func test_should_calculate_votes_of_a_person_with_penalty():
	# given:
	person.votes.append("Bound")
	person.votes.append("Cría Cuervos")
	person.votes.append("Bad Luck Banging or Loony Porn")
	person.penalty = 1
	
	# when:
	var result = calculator.calculate_votes_of_a_person(person)
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result["Bound"], 2)
	asserts.is_equal(result["Cría Cuervos"], 2)
	asserts.is_equal(result["Bad Luck Banging or Loony Porn"], 1)
