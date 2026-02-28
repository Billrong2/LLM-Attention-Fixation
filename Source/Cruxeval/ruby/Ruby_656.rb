def f(letters)
    a = []
    letters.each do |letter|
        if a.include?(letter)
            return 'no'
        end
        a << letter
    end
    'yes'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("yes", candidate.call(["b", "i", "r", "o", "s", "j", "v", "p"]))
  end
end
