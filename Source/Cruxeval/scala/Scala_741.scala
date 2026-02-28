import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long], p: Long): Long = {
        val prev_p = if (p - 1 < 0) nums.length - 1 else p - 1
        nums(prev_p.toInt)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 8l.toLong, 2l.toLong, 5l.toLong, 3l.toLong, 1l.toLong, 9l.toLong, 7l.toLong)), (6l)) == (1l));
    }

}
