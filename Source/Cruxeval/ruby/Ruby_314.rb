def f(text)
    if text.include?(',')
        before, _, after = text.partition(',')
        return after + ' ' + before
    end
    return ',' + text.partition(' ')[-1] + ' 0'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(" 105, -90 244", candidate.call("244, 105, -90"))
  end
end
