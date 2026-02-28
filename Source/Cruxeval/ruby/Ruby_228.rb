def f(text, splitter)
    text.downcase.split.join(splitter)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("llthh#saflapkphtswp", candidate.call("LlTHH sAfLAPkPhtsWP", "#"))
  end
end
