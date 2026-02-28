def f(haystack, needle)
    (haystack.index(needle)..0).each do |i|
        return i if haystack[i..-1] == needle
    end
    -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-1, candidate.call("345gerghjehg", "345"))
  end
end
