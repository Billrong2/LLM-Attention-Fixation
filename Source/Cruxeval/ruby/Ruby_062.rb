def f(user)
    if user.keys.length > user.values.length
        user.keys
    else
        user.values
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["ja", "nee", "coke", "zoo"], candidate.call({"eating" => "ja", "books" => "nee", "piano" => "coke", "excitement" => "zoo"}))
  end
end
