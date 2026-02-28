def f(d)
  r = {
    'c' => d.dup,
    'd' => d.dup
  }
  [r['c'].equal?(r['d']), r['c'] == r['d']]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([false, true], candidate.call({"i" => "1", "love" => "parakeets"}))
  end
end
