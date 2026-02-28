def f(base, k, v)
    base[k] = v
    base
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({37 => "forty-five", "23" => "what?"}, candidate.call({37 => "forty-five"}, "23", "what?"))
  end
end
