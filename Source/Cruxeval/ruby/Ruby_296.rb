def f(url)
    url.sub('http://www.', '')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("https://www.www.ekapusta.com/image/url", candidate.call("https://www.www.ekapusta.com/image/url"))
  end
end
