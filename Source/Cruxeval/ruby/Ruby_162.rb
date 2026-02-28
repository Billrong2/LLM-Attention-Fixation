def f(text)
  result = ''
  text.each_char do |char|
    if char.match?(/[[:alnum:]]/)
      result += char.upcase
    end
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("СBISHOPSWIFT", candidate.call("с bishop.Swift"))
  end
end
