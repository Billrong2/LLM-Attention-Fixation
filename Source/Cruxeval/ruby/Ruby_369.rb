def f(var)
    if var.match?(/^\d+$/)
        return "int"
    elsif var.sub('.', '').match?(/^\d+$/)
        return "float"
    elsif var.count(' ') == var.length - 1
        return "str"
    elsif var.length == 1
        return "char"
    else
        return "tuple"
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("tuple", candidate.call(" 99 777"))
  end
end
