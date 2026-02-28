import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val numsBuffer = ListBuffer(nums: _*)
        val count = numsBuffer.length
        for (i <- count - 1 to 0 by -1) {
            numsBuffer.insert(i, numsBuffer.remove(0))
        }
        numsBuffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, -5l.toLong, -4l.toLong))).equals((List[Long](-4l.toLong, -5l.toLong, 0l.toLong))));
    }

}
