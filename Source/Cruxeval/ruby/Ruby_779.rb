def f(text)
    values = text.split
    '${first}y, ${second}x, ${third}r, ${fourth}p' % {
        'first' => values[0],
        'second' => values[1],
        'third' => values[2],
        'fourth' => values[3]
    }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("${first}y, ${second}x, ${third}r, ${fourth}p", candidate.call("python ruby c javascript"))
  end
end
