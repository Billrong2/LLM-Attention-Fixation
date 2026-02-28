def f(names)
    count = names.length
    number_of_names = 0
    names.each do |name|
        if name.match?(/\A[a-zA-Z]+\z/)
            number_of_names += 1
        end
    end
    number_of_names
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call(["sharron", "Savannah", "Mike Cherokee"]))
  end
end
