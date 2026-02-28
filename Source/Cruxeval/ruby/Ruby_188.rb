def f(strings)
    new_strings = []
    strings.each do |string|
        first_two = string[0..1]
        if first_two.start_with?('a') || first_two.start_with?('p')
            new_strings << first_two
        end
    end
    
    new_strings
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["a"], candidate.call(["a", "b", "car", "d"]))
  end
end
