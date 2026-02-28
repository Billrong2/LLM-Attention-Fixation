def f(string)
    begin
        string.rindex('e')
    rescue NoMethodError
        "Nuk"
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(8, candidate.call("eeuseeeoehasa"))
  end
end
