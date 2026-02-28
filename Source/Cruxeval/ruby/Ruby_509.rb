def f(value, width)
    if value >= 0
        value.to_s.rjust(width, '0')
    else
        ('-' + (-value).to_s).rjust(width, '0')
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("5", candidate.call(5, 1))
  end
end
