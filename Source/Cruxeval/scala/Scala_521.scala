import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        val m = nums.max
        var reversedNums = nums
        for (i <- 0 until m.toInt) {
            reversedNums = reversedNums.reverse
        }
        reversedNums
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](43l.toLong, 0l.toLong, 4l.toLong, 77l.toLong, 5l.toLong, 2l.toLong, 0l.toLong, 9l.toLong, 77l.toLong))).equals((List[Long](77l.toLong, 9l.toLong, 0l.toLong, 2l.toLong, 5l.toLong, 77l.toLong, 4l.toLong, 0l.toLong, 43l.toLong))));
    }

}
