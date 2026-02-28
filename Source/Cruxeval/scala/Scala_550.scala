import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val mutableNums = ListBuffer(nums: _*)
        for (i <- 0 until mutableNums.length) {
            mutableNums.insert(i, pow(mutableNums(i), 2).toLong)
        }
        mutableNums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 4l.toLong))).equals((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 2l.toLong, 4l.toLong))));
    }

}
