def f(forest, animal)
    index = forest.index(animal)
    result = forest.chars.to_a
    while index < forest.length - 1 do
        result[index] = forest[index + 1]
        index += 1
    end

    if index == forest.length - 1
        result[index] = '-'
    end

    result.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("2io 12 tfiqr.-", candidate.call("2imo 12 tfiqr.", "m"))
  end
end
