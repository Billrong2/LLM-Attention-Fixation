def f(text)
  topic, sep, problem = text.rpartition('|')
  if problem == 'r'
      problem = topic.gsub('u', 'p')
  end
  return topic, problem
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["", "xduaisf"], candidate.call("|xduaisf"))
  end
end
