import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val numsBuffer = ArrayBuffer(nums: _*)
        val count = numsBuffer.length
        for (i <- 0 until count / 2) {
            val temp = numsBuffer(i)
            numsBuffer(i) = numsBuffer(count - i - 1)
            numsBuffer(count - i - 1) = temp
        }
        numsBuffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 6l.toLong, 1l.toLong, 3l.toLong, 1l.toLong))).equals((List[Long](1l.toLong, 3l.toLong, 1l.toLong, 6l.toLong, 2l.toLong))));
    }

}
