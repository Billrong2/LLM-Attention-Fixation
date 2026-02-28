def f(text)
  text.each_char.all? { |char| char.match?(/\s|\u3000/) }
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call(" 	  　"))
  end
end
