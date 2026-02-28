def f(text, c)
    ls = text.chars.to_a
    unless text.include?(c)
        raise ArgumentError.new("Text has no #{c}")
    end
    ls.delete_at(text.rindex(c))
    ls.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("uufh", candidate.call("uufhl", "l"))
  end
end
