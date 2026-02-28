def f(text)
    if text.upcase == text
        'ALL UPPERCASE'
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Hello Is It MyClass", candidate.call("Hello Is It MyClass"))
  end
end
