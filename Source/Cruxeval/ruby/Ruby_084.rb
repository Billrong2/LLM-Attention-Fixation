def f(text)
    arr = text.split
    result = []
    arr.each do |item|
        if item.end_with?('day')
            item += 'y'
        else
            item += 'day'
        end
        result << item
    end
    result.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("nwvday mefday ofmeday bdrylday", candidate.call("nwv mef ofme bdryl"))
  end
end
