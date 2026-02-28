import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val result = ListBuffer[Long]()

        for (i <- nums.indices) {
            result += nums(i)
            if (nums(i) % 2 == 1) {
                result += nums(i)
            }
        }

        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 3l.toLong, 4l.toLong, 6l.toLong, -2l.toLong))).equals((List[Long](2l.toLong, 3l.toLong, 3l.toLong, 4l.toLong, 6l.toLong, -2l.toLong))));
    }

}
