def f(text, to_place)
    after_place = text[0..text.index(to_place, 0)]
    before_place = text[text.index(to_place, 0)+1..-1]
    after_place + before_place
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("some text", candidate.call("some text", "some"))
  end
end
