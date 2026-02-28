def f(d)
    i = d.length - 1
    key = d.keys[i]
    d.delete(key)
    return key, d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["c", {"e" => 1, "d" => 2}], candidate.call({"e" => 1, "d" => 2, "c" => 3}))
  end
end
