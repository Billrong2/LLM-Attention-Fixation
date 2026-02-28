def f(s)
    s.chars.select { |c| c =~ /\s/ }.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("

 ", candidate.call("
giyixjkvu
 rgjuo"))
  end
end
