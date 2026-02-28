def f(text, letter)
    new_text = text.gsub(/\w/,"")
    new_text.split(letter).length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("c, c, c ,c, c", "c"))
  end
end
