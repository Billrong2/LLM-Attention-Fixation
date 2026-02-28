def f(text)
  a = []
  text.each_char do |char|
    a << char unless char =~ /\d/
  end
  a.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("seiq d", candidate.call("seiq7229 d27"))
  end
end
