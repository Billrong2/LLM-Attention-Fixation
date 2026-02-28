def f(text)
    begin
        while text.include?('nnet lloP')
            text.gsub!('nnet lloP', 'nnet loLp')
        end
    ensure
        return text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("a_A_b_B3 ", candidate.call("a_A_b_B3 "))
  end
end
