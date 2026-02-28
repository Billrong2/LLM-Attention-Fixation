def f(graph)
    new_graph = {}
    graph.each do |key, value|
        new_graph[key] = {}
        value.each_key do |subkey|
            new_graph[key][subkey] = ''
        end
    end
    new_graph
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
