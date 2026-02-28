def f(text)
    dic = {}
    text.each_char do |char|
        dic[char] = dic[char].to_i + 1
    end
    dic.each do |key, value|
        dic[key] = 1 if value > 1
    end
    dic
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"a" => 1}, candidate.call("a"))
  end
end
