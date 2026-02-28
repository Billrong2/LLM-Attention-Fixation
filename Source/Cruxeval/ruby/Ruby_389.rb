def f(total, arg)
    if arg.is_a?(Array)
        arg.each do |e|
            total.concat(e)
        end
    else
        total.concat(arg.chars)
    end
    total
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["1", "2", "3", "n", "a", "m", "m", "o"], candidate.call(["1", "2", "3"], "nammo"))
  end
end
