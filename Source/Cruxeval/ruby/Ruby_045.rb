def f(text, letter)
  counts = {}
  text.each_char do |char|
    if counts[char].nil?
      counts[char] = 1
    else
      counts[char] += 1
    end
  end
  counts[letter] || 0
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("za1fd1as8f7afasdfam97adfa", "7"))
  end
end
