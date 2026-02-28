def f(text)
    texts = text.split
    if !texts.empty?
        xtexts = texts.select { |t| t.ascii_only? && !['nada', '0'].include?(t) }
        xtexts.empty? ? 'nada' : xtexts.max_by(&:length)
    else
        'nada'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("nada", candidate.call(""))
  end
end
