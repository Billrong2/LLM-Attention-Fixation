def f(playlist, liker_name, song_index)
    playlist[liker_name] ||= []
    playlist[liker_name] << song_index
    playlist
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"aki" => ["1", "5", "2"]}, candidate.call({"aki" => ["1", "5"]}, "aki", "2"))
  end
end
