def f(bots)
    clean = []
    bots.each do |username|
        clean << username[0..1] + username[-3..-1] unless username.upcase == username
    end
    clean.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call(["yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"]))
  end
end
