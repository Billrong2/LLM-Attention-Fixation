import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        var mutableNums = ArrayBuffer(nums: _*)
        val count = mutableNums.length
        if (count == 0) {
            mutableNums = ArrayBuffer.fill(nums.last.toInt)(0)
        } else if (count % 2 == 0) {
            mutableNums.clear()
        } else {
            mutableNums.trimStart(count / 2)
        }
        mutableNums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-6l.toLong, -2l.toLong, 1l.toLong, -3l.toLong, 0l.toLong, 1l.toLong))).equals((List[Long]())));
    }

}
