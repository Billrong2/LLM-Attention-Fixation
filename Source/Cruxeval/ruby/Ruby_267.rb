def f(text, space)
    if space < 0
        text
    else
        text.ljust(text.length / 2 + space)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("sowpf", candidate.call("sowpf", -7))
  end
end
