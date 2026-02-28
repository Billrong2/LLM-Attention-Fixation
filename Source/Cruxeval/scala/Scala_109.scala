import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], spot : Long, idx : Long) : List[Long] = {
        var new_nums = nums.toBuffer
        new_nums.insert(spot.toInt, idx)
        new_nums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 0l.toLong, 1l.toLong, 1l.toLong)), (0l), (9l)).equals((List[Long](9l.toLong, 1l.toLong, 0l.toLong, 1l.toLong, 1l.toLong))));
    }

}
