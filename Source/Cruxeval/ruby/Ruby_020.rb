def f(text)
    result = ''
    (text.length - 1).downto(0) do |i|
        result += text[i]
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(",saw", candidate.call("was,"))
  end
end
