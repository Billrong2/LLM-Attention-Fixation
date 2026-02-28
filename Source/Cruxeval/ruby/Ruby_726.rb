def f(text)
    ws = 0
    text.each_char do |s|
        ws += 1 if s == ' '
    end
    return ws, text.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 34], candidate.call("jcle oq wsnibktxpiozyxmopqkfnrfjds"))
  end
end
