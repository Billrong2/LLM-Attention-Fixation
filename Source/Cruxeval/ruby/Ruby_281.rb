def f(c, index, value)
    c[index] = value
    if value >= 3
        c['message'] = 'xcrWt'
    else
        c.delete('message')
    end
    c
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => 2, 3 => 4, 5 => 6, 8 => 2}, candidate.call({1 => 2, 3 => 4, 5 => 6, "message" => "qrTHo"}, 8, 2))
  end
end
