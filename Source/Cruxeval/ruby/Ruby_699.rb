def f(text, elem)
    if elem != ''
        while text.start_with?(elem)
            text.gsub!(elem, '')
        end
        while elem.start_with?(text)
            elem.gsub!(text, '')
        end
    end
    [elem, text]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["1", "some"], candidate.call("some", "1"))
  end
end
