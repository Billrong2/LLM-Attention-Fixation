def f(text, changes)
    result = ''
    count = 0
    changes = changes.split('')
    text.each_char do |char|
        if char.include?('e')
            result += char
        else
            result += changes[count % changes.length]
        end
        count += (char.include?('e') ? 0 : 1)
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("yesyes", candidate.call("fssnvd", "yes"))
  end
end
