import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val mutableNums = ListBuffer[Long]() ++= nums
        val count = mutableNums.length
        for (i <- 0 until count) {
            mutableNums.insert(i, mutableNums(i) * 2)
        }
        mutableNums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 8l.toLong, -2l.toLong, 9l.toLong, 3l.toLong, 3l.toLong))).equals((List[Long](4l.toLong, 4l.toLong, 4l.toLong, 4l.toLong, 4l.toLong, 4l.toLong, 2l.toLong, 8l.toLong, -2l.toLong, 9l.toLong, 3l.toLong, 3l.toLong))));
    }

}
