import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var result = nums
        for (_ <- 0 until nums.length - 1) {
            result = result.reverse
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, -9l.toLong, 7l.toLong, 2l.toLong, 6l.toLong, -3l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, -9l.toLong, 7l.toLong, 2l.toLong, 6l.toLong, -3l.toLong, 3l.toLong))));
    }

}
