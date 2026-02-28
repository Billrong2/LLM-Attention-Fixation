def f(sentence)
    return '' if sentence == ''
    sentence = sentence.gsub('(', '')
    sentence = sentence.gsub(')', '')
    sentence.capitalize.gsub(' ', '')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Abb", candidate.call("(A (b B))"))
  end
end
