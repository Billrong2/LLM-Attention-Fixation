def f(text)
  new_text = text.split('')
  new_text.each_with_index do |character, i|
    new_character = character.swapcase
    new_text[i] = new_character
  end
  new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("DST VAVF N DMV DFVM GAMCU DGCVB.", candidate.call("dst vavf n dmv dfvm gamcu dgcvb."))
  end
end
