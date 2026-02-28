def f(messages)
    phone_code = "+353"
    result = []
    messages.each do |message|
        result.append((message + phone_code.split('')).join(';'))
    end
    result.join('. ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Marie;Nelson;Oscar;+;3;5;3", candidate.call([["Marie", "Nelson", "Oscar"]]))
  end
end
