def f(out, mapping)
  mapping.each do |key, value|
    out = out.format_map(mapping)
    if out.scan(/\{\w\}/).length == 0
      break
    end
    mapping[key][1] = mapping[key][1].reverse
  end
  out
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("{{{{}}}}", candidate.call("{{{{}}}}", {}))
  end
end
