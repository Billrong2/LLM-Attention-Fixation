def f(text, new_ending)
    result = text.split('')
    result += new_ending.split('')
    result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("jrowdlp", candidate.call("jro", "wdlp"))
  end
end
