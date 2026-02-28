def f(dic)
  d = {}
  dic.each do |key, value|
    d[key] = dic.shift[1]
  end
  d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
