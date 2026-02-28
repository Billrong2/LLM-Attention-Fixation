def f(d)
  r = {}
  while d.length > 0
    r = r.merge(d)
    d.delete(d.keys.max)
  end
  r
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({3 => "A3", 1 => "A1", 2 => "A2"}, candidate.call({3 => "A3", 1 => "A1", 2 => "A2"}))
  end
end
