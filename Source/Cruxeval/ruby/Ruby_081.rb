def f(dic, inx)
    begin
        dic[dic.keys[dic.keys.index(inx)]] = dic.keys[dic.keys.index(inx)].downcase
    rescue
    end
    dic.to_a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([["Bulls", "bulls"], ["White Sox", 45]], candidate.call({"Bulls" => 23, "White Sox" => 45}, "Bulls"))
  end
end
