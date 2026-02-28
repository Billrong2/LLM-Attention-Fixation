def f(d)
    keys = []
    d.each { |k, v| keys << "#{k} => #{v}" }
    keys
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["-4 => 4", "1 => 2", "- => -3"], candidate.call({"-4" => "4", "1" => "2", "-" => "-3"}))
  end
end
