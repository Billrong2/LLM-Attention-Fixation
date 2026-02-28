import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val mutableNums = ListBuffer(nums: _*)
        val count = mutableNums.length
        while (mutableNums.length > count / 2) {
            mutableNums.clear()
        }
        mutableNums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 1l.toLong, 2l.toLong, 3l.toLong, 1l.toLong, 6l.toLong, 3l.toLong, 8l.toLong))).equals((List[Long]())));
    }

}
