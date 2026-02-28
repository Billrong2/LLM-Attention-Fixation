def f(text)
    text.split(':')[0].count('#')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("#! : #!"))
  end
end
