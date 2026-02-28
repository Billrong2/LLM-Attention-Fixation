def f(sentence)
    sentence.each_char do |c|
        return false if !c.ascii_only?
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("1z1z1"))
  end
end
