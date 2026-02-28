def f(doc)
    doc.each_char do |x|
        if x.match?(/[a-zA-Z]/)
            return x.capitalize
        end
    end
    '-'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("R", candidate.call("raruwa"))
  end
end
