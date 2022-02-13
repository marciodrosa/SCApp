extends WATTest

func test_should_initialize():
	var person = SCPerson.new("John")
	asserts.is_equal(person.name, "John")
	asserts.is_equal(person.penalty, 0)
	asserts.is_not_null(person.votes)
	asserts.is_empty(person.votes)
