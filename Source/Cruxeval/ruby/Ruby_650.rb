def f(string, substring)
    while string.start_with?(substring)
        string = string[substring.length..-1]
    end
    string
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("", "A"))
  end
end
