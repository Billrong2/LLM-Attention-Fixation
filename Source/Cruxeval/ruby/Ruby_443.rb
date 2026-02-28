def f(text)
  text.each_char do |space|
    if space == ' '
      text = text.lstrip
    else
      text = text.gsub('cd', space)
    end
  end
  text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("lorem ipsum", candidate.call("lorem ipsum"))
  end
end
