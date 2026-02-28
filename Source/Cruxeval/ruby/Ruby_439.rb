def f(value)
    parts = value.partition(' ').each_slice(2).map(&:first)
    parts.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("coscifysu", candidate.call("coscifysu"))
  end
end
