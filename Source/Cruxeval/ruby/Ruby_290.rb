def f(text, prefix)
    if text.start_with?(prefix)
        text.delete_prefix(prefix)
    elsif text.include?(prefix)
        text.gsub(prefix, '').strip
    else
        text.upcase
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ABIXAAAILY", candidate.call("abixaaaily", "al"))
  end
end
