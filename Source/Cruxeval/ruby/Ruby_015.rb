def f(text, wrong, right)
    new_text = text.gsub(wrong, right)
    new_text.upcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ZN KGD JW LNT", candidate.call("zn kgd jw lnt", "h", "u"))
  end
end
