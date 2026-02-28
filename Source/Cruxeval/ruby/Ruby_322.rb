def f(chemicals, num)
    fish = chemicals[1..-1]
    chemicals.reverse!
    num.times do
        fish << chemicals.delete_at(1)
    end
    chemicals.reverse!
    chemicals
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["lsi", "s", "t", "t", "d"], candidate.call(["lsi", "s", "t", "t", "d"], 0))
  end
end
