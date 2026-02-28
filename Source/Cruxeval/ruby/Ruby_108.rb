def f(var)
    if var.is_a?(Array)
        amount = var.length
    elsif var.is_a?(Hash)
        amount = var.keys.length
    else
        amount = 0
    end

    nonzero = amount > 0 ? amount : 0
    return nonzero
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call(1))
  end
end
