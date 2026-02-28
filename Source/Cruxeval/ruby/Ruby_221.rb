def f(text, delim)
    first, second = text.split(delim)
    "#{second}#{delim}#{first}"
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(".bpxa24fc5", candidate.call("bpxa24fc5.", "."))
  end
end
