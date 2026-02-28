def f(text)
    letters = ''
    text.split('').each do |char|
        if char =~ /[[:alnum:]]/
            letters += char
        end
    end
    letters
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("we32r71g72ug94823658324", candidate.call("we@32r71g72ug94=(823658*!@324"))
  end
end
