def f(text, suffix)
    if !suffix.empty? && text.include?(suffix[-1])
        return f(text.chomp(suffix[-1]), suffix[0...-1])
    else
        return text
    end
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("rpytt", candidate.call("rpyttc", "cyt"))
  end
end
