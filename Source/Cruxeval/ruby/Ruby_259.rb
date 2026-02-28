def f(text)
    new_text = []
    text.each_char do |character|
        if character == character.upcase && character.match(/[a-zA-Z]/)
            new_text.insert(new_text.length / 2, character)
        end
    end
    if new_text.length == 0
        new_text = ['-']
    end
    return new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("RES", candidate.call("String matching is a big part of RexEx library."))
  end
end
