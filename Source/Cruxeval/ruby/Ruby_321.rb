def f(update, starting)
  d = starting.dup
  update.each do |k, v|
    if d.key?(k)
      d[k] += v
    else
      d[k] = v
    end
  end
  d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"desciduous" => 2}, candidate.call({}, {"desciduous" => 2}))
  end
end
