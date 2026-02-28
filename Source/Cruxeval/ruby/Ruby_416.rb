def f(text, old, new)
    index = text.rindex(old, 0)
    result = text.chars.to_a
    while index > 0
        result[index, old.length] = new.chars.to_a
        index = text.rindex(old, 0, index)
    end
    result.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("jysrhfm ojwesf xgwwdyr dlrul ymba bpq", candidate.call("jysrhfm ojwesf xgwwdyr dlrul ymba bpq", "j", "1"))
  end
end
