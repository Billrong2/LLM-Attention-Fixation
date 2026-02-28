def f(text, pref)
    if pref.is_a?(Array)
        pref.map { |x| text.start_with?(x) }.join(', ')
    else
        text.start_with?(pref)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("Hello World", "W"))
  end
end
