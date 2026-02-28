import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        val numsBuffer = nums.toBuffer
        for (i <- 0 until nums.length) {
            numsBuffer.insert(i, numsBuffer(i))
        }
        numsBuffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 3l.toLong, -1l.toLong, 1l.toLong, -2l.toLong, 6l.toLong))).equals((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 3l.toLong, -1l.toLong, 1l.toLong, -2l.toLong, 6l.toLong))));
    }

}
