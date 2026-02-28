def f(input_string)
    table = {'a' => 'i', 'i' => 'o', 'o' => 'u', 'e' => 'a', 'A' => 'I', 'I' => 'O', 'O' => 'U', 'E' => 'A'}
    while input_string.include?('a') || input_string.include?('A')
        input_string = input_string.tr(table.keys.join, table.values.join)
    end
    input_string
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("biec", candidate.call("biec"))
  end
end
