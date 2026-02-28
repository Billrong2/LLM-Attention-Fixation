def f(s, c1, c2)
    return s if s == ''
    
    ls = s.split(c1)
    ls.each_with_index do |item, index|
        ls[index] = item.sub(c1, c2) if item.include?(c1)
    end
    
    ls.join(c1)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("", "mi", "siast"))
  end
end
