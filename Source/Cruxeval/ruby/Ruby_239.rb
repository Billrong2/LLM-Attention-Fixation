def f(text, froms)
    text = text.sub(/^[#{froms}]+/, '')
    text = text.sub(/[#{froms}]+$/, '')
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("1co", candidate.call("0 t 1cos ", "st 0	
  "))
  end
end
