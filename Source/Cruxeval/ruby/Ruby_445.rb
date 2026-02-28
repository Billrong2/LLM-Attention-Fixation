def f(names)
    parts = names.split(',')
    parts.each_with_index do |part, i|
        parts[i] = part.gsub(' and', '+').split(/(\W)/).map(&:capitalize).join.gsub('+', ' and')
    end
    parts.join(', ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Carrot,  Banana,  and Strawberry", candidate.call("carrot, banana, and strawberry"))
  end
end
