def f(text)
    counter = 0
    text.each_char do |char|
        if char.match?(/[a-zA-Z]/)
            counter += 1
        end
    end
    counter
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("l000*"))
  end
end
