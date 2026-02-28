def f(array)
  result = []
  array.each do |elem|
    if elem.ascii_only? || (elem.is_a?(Integer) && !(elem.abs.to_s.ascii_only?))
      result << elem
    end
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["a", "b", "c"], candidate.call(["a", "b", "c"]))
  end
end
