def f(prefix, text)
    if text.start_with?(prefix)
        text
    else
        prefix + text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mjsmjqwmjsqjwisojqwiso", candidate.call("mjs", "mjqwmjsqjwisojqwiso"))
  end
end
