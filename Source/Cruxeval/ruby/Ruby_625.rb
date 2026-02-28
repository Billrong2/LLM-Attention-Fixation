def f(text)
    count = 0
    text.each_char do |i|
        if '.?!.,'.include?(i)
            count += 1
        end
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call("bwiajegrwjd??djoda,?"))
  end
end
