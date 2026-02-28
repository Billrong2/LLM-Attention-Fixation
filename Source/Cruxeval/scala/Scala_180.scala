import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        var a = -1L
        var b = nums.tail
        val mutableNums = ListBuffer(nums: _*)
        
        while (a <= b.head) {
            mutableNums -= b.head
            a = 0
            b = b.tail
        }
        
        mutableNums.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, 5l.toLong, 3l.toLong, -2l.toLong, -6l.toLong, 8l.toLong, 8l.toLong))).equals((List[Long](-1l.toLong, -2l.toLong, -6l.toLong, 8l.toLong, 8l.toLong))));
    }

}
