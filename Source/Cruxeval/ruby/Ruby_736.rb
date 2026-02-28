def f(text, insert)
    whitespaces = ['\t', '\r', '\v', ' ', '\f', '\n']
    clean = ''
    text.each_char do |char|
        if whitespaces.include?(char)
            clean += insert
        else
            clean += char
        end
    end
    clean
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("pichiwa", candidate.call("pi wa", "chi"))
  end
end
