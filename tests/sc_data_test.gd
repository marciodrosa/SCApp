extends WATTest

func test_should_initialize():
	var data = SCData.new()
	asserts.is_equal(data.voters.size(), 4)
	asserts.is_equal(data.voters[0].name, "Felipe")
	asserts.is_equal(data.voters[1].name, "Júlia")
	asserts.is_equal(data.voters[2].name, "Márcio")
	asserts.is_equal(data.voters[3].name, "Rafa")
	asserts.is_null(data.curator)
	asserts.is_not_null(data.movies)
	asserts.is_empty(data.movies)
