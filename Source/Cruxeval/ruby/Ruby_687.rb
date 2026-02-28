def f(text)
    t = text.split('')
    t.delete_at(t.length / 2)
    t.push(text.downcase)
    t.join(':')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("R:j:u:g: :z:u:f:E:rjug nzufe", candidate.call("Rjug nzufE"))
  end
end
