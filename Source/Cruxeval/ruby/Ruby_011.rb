def f(a, b)
  b.each do |key, value|
    if !a.key?(key)
      a[key] = [value]
    else
      a[key] << value
    end
  end
  a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"foo" => ["bar"]}, candidate.call({}, {"foo" => "bar"}))
  end
end
