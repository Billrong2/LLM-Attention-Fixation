def f(text, suffix, num)
    str_num = num.to_s
    text.end_with?(suffix + str_num)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("friends and love", "and", 3))
  end
end
