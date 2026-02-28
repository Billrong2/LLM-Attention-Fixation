def f(text)
    text_arr = []
    (0..text.length-1).each do |j|
        text_arr << text[j..-1]
    end
    text_arr
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["123", "23", "3"], candidate.call("123"))
  end
end
