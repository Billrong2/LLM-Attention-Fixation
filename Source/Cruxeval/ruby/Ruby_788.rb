def f(text, suffix)
    if suffix.start_with?("/")
        text + suffix[1..-1]
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hello.txt", candidate.call("hello.txt", "/"))
  end
end
