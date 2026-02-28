def f(cart)
    while cart.length > 5
        cart.pop
    end
    cart
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
