extends WATTest

var person: SCPerson

func pre():
	person = SCPerson.new("John")

func test_should_initialize():
	asserts.is_equal(person.name, "John")
	asserts.is_equal(person.penalty, 0)
	asserts.is_not_null(person.votes)
	asserts.is_empty(person.votes)

func test_should_return_votes_as_string():
	# given:
	person.votes.append("Bound")
	person.votes.append("Cría Cuervos")
	person.votes.append("Bad Luck Banging or Loony Porn")
	
	# then:
	asserts.is_equal(person.votes_to_string(), "*John:*\n1. Bound\n2. Cría Cuervos\n3. Bad Luck Banging or Loony Porn")
