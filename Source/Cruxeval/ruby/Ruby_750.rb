def f(char_map, text)
  new_text = ''
  text.each_char do |ch|
    val = char_map[ch]
    if val.nil?
      new_text += ch
    else
      new_text += val
    end
  end
  new_text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hbd", candidate.call({}, "hbd"))
  end
end
