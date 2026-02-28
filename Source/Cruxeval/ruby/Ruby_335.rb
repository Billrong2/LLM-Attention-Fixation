def f(text, to_remove)
    new_text = text.split('')
    if new_text.include?(to_remove)
        index = new_text.index(to_remove)
        new_text.delete_at(index)
        new_text.insert(index, '?')
        new_text.delete('?')
    end
    new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("sjbrfqmw", candidate.call("sjbrlfqmw", "l"))
  end
end
