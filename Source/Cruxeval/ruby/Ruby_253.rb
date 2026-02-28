def f(text, pref)
    length = pref.length
    if pref == text[0, length]
        text[length..-1]
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("umwwfv", candidate.call("kumwwfv", "k"))
  end
end
