def f(a)
  s = a.to_a.reverse.to_h
  s.map{|k, v| "(#{k}, '#{v}')"}.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("(12, 'Rwrepny') (15, 'Qltuf')", candidate.call({15 => "Qltuf", 12 => "Rwrepny"}))
  end
end
