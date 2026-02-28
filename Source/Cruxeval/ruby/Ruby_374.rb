def f(seq, v)
    a = []
    seq.each do |i|
        if i.end_with?(v)
            a << i * 2
        end
    end
    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["zzzz"], candidate.call(["oH", "ee", "mb", "deft", "n", "zz", "f", "abA"], "zz"))
  end
end
