def f(text)
    d = {}
    text.gsub('-', '').downcase.each_char do |char|
        d[char] = d[char].to_i + 1
    end
    d = d.sort_by { |k, v| v }
    d.map { |i, val| val }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1, 1, 1, 1], candidate.call("x--y-z-5-C"))
  end
end
