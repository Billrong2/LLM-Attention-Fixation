def f(text)
    if text.match?(/^\p{Alnum}+$/)
        text.scan(/\d+/).join('')
    else
        text.split('').join('')
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("816", candidate.call("816"))
  end
end
