def f(first, second)
    if first.length < 10 || second.length < 10
        return 'no'
    end

    for i in 0..4
        if first[i] != second[i]
            return 'no'
        end
    end

    first.concat(second)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("no", candidate.call([1, 2, 1], [1, 1, 2]))
  end
end
