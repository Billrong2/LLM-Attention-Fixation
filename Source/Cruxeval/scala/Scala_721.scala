import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        var mutableNums = ArrayBuffer(nums: _*)
        val count = mutableNums.length
        for (num <- 2 until count) {
            mutableNums = mutableNums.sorted
        }
        mutableNums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-6l.toLong, -5l.toLong, -7l.toLong, -8l.toLong, 2l.toLong))).equals((List[Long](-8l.toLong, -7l.toLong, -6l.toLong, -5l.toLong, 2l.toLong))));
    }

}
