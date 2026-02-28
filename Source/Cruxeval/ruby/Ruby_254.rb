def f(text, repl)
    trans = Hash[text.downcase.chars.zip(repl.downcase.chars)]
    text.tr(trans.keys.join, trans.values.join)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("lwwer case", candidate.call("upper case", "lower case"))
  end
end
