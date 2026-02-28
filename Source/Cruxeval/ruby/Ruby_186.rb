def f(text)
    text.split.map(&:lstrip).join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("pvtso", candidate.call("pvtso"))
  end
end
