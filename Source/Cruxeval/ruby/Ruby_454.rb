def f(d, count)
  new_hash = {}
  count.times do
    d = d.dup
    new_hash = d.merge(new_hash)
  end
  new_hash
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({"a" => 2, "b" => [], "c" => {}}, 0))
  end
end
