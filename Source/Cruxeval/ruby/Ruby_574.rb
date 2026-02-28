def f(simpsons)
    while !simpsons.empty?
        pop = simpsons.pop
        return pop if pop == pop.capitalize
    end
    pop
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Costanza", candidate.call(["George", "Michael", "George", "Costanza"]))
  end
end
