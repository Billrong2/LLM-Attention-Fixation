def f(price, product)
    inventory = ['olives', 'key', 'orange']
    if !inventory.include?(product)
        return price
    else
        price *= 0.85
        inventory.delete(product)
    end
    price
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(8.5, candidate.call(8.5, "grapes"))
  end
end
