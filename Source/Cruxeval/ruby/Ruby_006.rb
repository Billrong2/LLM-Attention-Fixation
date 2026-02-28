def f(dic)
    dic.sort_by { |k, v| k.to_s.length }[0...-1].each do |k, v|
        dic.delete(k)
    end
    dic.to_a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([["74", 31]], candidate.call({"11" => 52, "65" => 34, "a" => 12, "4" => 52, "74" => 31}))
  end
end
