def f(text)
    new_text = text.chars.map { |c| c.match?(/\d/) ? c : '*' }.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("5*83*23***", candidate.call("5f83u23saa"))
  end
end
