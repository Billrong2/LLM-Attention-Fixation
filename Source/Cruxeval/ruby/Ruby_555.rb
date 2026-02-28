def f(text, tabstop)
    text = text.gsub("\n", '_____')
    text = text.gsub("\t", ' ' * tabstop)
    text = text.gsub('_____', "\n")
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("odes  code  well", candidate.call("odes	code	well", 2))
  end
end
