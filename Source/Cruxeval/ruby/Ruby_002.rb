def f(text)
    new_text = text.split('')
    new_text.delete('+')
    new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hbtofdeiequ", candidate.call("hbtofdeiequ"))
  end
end
