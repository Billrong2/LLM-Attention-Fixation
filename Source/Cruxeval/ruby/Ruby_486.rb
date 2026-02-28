def f(dic)
    dic_op = dic.dup
    dic_op.each do |key, val|
        dic_op[key] = val * val
    end
    dic_op
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => 1, 2 => 4, 3 => 9}, candidate.call({1 => 1, 2 => 2, 3 => 3}))
  end
end
