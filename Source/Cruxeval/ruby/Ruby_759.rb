def f(text, sub)
    index = []
    starting = 0
    while starting != -1
        starting = text.index(sub, starting) || -1
        if starting != -1
            index.push(starting)
            starting += sub.length
        end
    end
    index
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call("egmdartoa", "good"))
  end
end
