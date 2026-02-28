def f(text, characters)
    character_list = characters.split('') + [' ', '_']

    i = 0
    while i < text.length && character_list.include?(text[i])
        i += 1
    end

    return text[i..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("2nm_28in", candidate.call("2nm_28in", "nm"))
  end
end
