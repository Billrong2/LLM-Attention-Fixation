def f(text)
    $g, $field = nil, nil
    $field = text.gsub(' ', '')
    $g = text.gsub('0', ' ')
    text.gsub('1', 'i')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0", candidate.call("00000000 00000000 01101100 01100101 01101110"))
  end
end
