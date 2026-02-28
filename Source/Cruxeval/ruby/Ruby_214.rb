def f(sample)
    i = -1
    while sample[i+1..-1].index('/') != nil do
        i = sample[i+1..-1].index('/') + i + 1
    end
    sample[0..i-1].rindex('/')
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(7, candidate.call("present/here/car%2Fwe"))
  end
end
