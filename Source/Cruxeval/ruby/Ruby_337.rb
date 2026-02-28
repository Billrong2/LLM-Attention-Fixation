def f(txt)
    d = []
    txt.each_char do |c|
        next if c.match?(/\d/)
        if c.match?(/[a-z]/)
            d << c.upcase
        elsif c.match?(/[A-Z]/)
            d << c.downcase
        end
    end
    d.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("LL", candidate.call("5ll6"))
  end
end
