def f(text)
    occ = {}
    text.each_char do |ch|
        name = {'a' => 'b', 'b' => 'c', 'c' => 'd', 'd' => 'e', 'e' => 'f'}
        name = name[ch] || ch
        occ[name] = occ[name].to_i + 1
    end
    occ.values
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1, 1, 1, 1, 1, 1], candidate.call("URW rNB"))
  end
end
