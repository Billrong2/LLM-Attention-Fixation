def f(text, sep, maxsplit)
    splitted = text.split(sep, -maxsplit)
    length = splitted.length
    new_splitted = splitted[0...length / 2].reverse
    new_splitted += splitted[length / 2..-1]
    new_splitted.join(sep)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ertubwi", candidate.call("ertubwi", "p", 5))
  end
end
