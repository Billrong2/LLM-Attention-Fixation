import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val numsBuffer = ListBuffer(nums: _*)
        val count = numsBuffer.length / 2
        for (_ <- 0 until count) {
            numsBuffer.remove(0)
        }
        numsBuffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 4l.toLong, 1l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
