def f(body)
    ls = body.chars
    dist = 0
    (0...ls.length - 1).each do |i|
        if ls[i - 2 >= 0 ? i - 2 : 0] == '\t'
            dist += (1 + ls[i - 1].count('\t')) * 3
        end
        ls[i] = '[' + ls[i] + ']'
    end
    ls.join.gsub(/\t/, ' ' * (4 + dist))
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("[
][
][y]
", candidate.call("

y
"))
  end
end
