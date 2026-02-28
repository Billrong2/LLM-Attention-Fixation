def f(multi_string)
    cond_string = multi_string.split.map(&:ascii_only?)
    if cond_string.include?(true)
        return multi_string.split.select(&:ascii_only?).join(', ')
    end
    return ''
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("I, am, hungry!, eat, food.", candidate.call("I am hungry! eat food."))
  end
end
