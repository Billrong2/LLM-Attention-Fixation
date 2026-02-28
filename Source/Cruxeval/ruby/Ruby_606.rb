def f(value)
    ls = value.chars.to_a
    ls.push('NHIB')
    ls.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ruamNHIB", candidate.call("ruam"))
  end
end
