def f(text, value)
    indexes = []
    (0..text.length-1).each do |i|
        if text[i] == value
            indexes << i
        end
    end
    new_text = text.chars
    indexes.reverse_each do |i|
        new_text.delete_at(i)
    end
    new_text.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("scedvtvtkwqfqn", candidate.call("scedvtvotkwqfoqn", "o"))
  end
end
