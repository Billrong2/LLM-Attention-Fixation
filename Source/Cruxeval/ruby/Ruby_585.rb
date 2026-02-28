def f(text)
    count = text.count(text[0])
    ls = text.split('')
    count.times do
        ls.shift
    end
    ls.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(",,,?", candidate.call(";,,,?"))
  end
end
