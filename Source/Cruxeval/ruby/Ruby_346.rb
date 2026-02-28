def f(filename)
    suffix = filename.split('.')[-1]
    f2 = filename + suffix.reverse
    f2.end_with?(suffix)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("docs.doc"))
  end
end
