def f(text, value)
    text_list = text.split('')
    text_list << value
    text_list.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("bcksrutq", candidate.call("bcksrut", "q"))
  end
end
