def f(text)
    a = 0
    if text[1, text.length].include? text[0]
        a += 1
    end
    for i in 0...(text.length - 1)
        if text[i+1, text.length].include? text[i]
            a += 1
        end
    end
    a
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(18, candidate.call("3eeeeeeoopppppppw14film3oee3"))
  end
end
