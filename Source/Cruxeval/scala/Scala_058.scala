import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val count = nums.length
        val result = ListBuffer[Long]()
        result ++= nums
        for (i <- (0 until count).map(_ % 2)) {
            result += nums(i)
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, 0l.toLong, 0l.toLong, 1l.toLong, 1l.toLong))).equals((List[Long](-1l.toLong, 0l.toLong, 0l.toLong, 1l.toLong, 1l.toLong, -1l.toLong, 0l.toLong, -1l.toLong, 0l.toLong, -1l.toLong))));
    }

}
