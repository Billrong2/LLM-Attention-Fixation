def f(student_marks, name)
    if student_marks.key?(name)
        value = student_marks.delete(name)
        value
    else
        'Name unknown'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Name unknown", candidate.call({"882afmfp" => 56}, "6f53p"))
  end
end
