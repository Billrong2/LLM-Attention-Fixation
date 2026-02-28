def f(text, char1, char2)
    t1a = []
    t2a = []
    char1.each_char { |c| t1a << c }
    char2.each_char { |c| t2a << c }
    t1 = Hash[t1a.zip(t2a)]
    text.tr(t1.keys.join, t1.values.join)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("gwrioad gmf rwdo sggoa", candidate.call("ewriyat emf rwto segya", "tey", "dgo"))
  end
end
