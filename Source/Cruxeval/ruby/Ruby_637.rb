def f(text)
    text = text.split(' ')
    text.each do |t|
        unless t.match?(/\A\d+\z/)
            return 'no'
        end
    end
    'yes'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("no", candidate.call("03625163633 d"))
  end
end
