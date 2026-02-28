def f(sentences)
    if sentences.split('.').all? { |sentence| sentence.to_i.to_s == sentence }
        'oscillating'
    else
        'not oscillating'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("not oscillating", candidate.call("not numbers"))
  end
end
