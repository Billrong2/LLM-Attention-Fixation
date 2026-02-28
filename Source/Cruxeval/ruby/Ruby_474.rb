def f(txt, marker)
    a = []
    lines = txt.split("\n")
    lines.each do |line|
        a << line.center(marker)
    end
    a.join("\n")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("#[)[]>[^e>
 8", candidate.call("#[)[]>[^e>
 8", -5))
  end
end
