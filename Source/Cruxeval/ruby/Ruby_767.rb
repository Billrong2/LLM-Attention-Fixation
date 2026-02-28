def f(text)
    a = text.strip.split(' ')
    a.each do |word|
        return '-' unless word.match?(/\A\d+\z/)
    end
    a.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("-", candidate.call("d khqw whi fwi bbn 41"))
  end
end
