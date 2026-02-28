import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : String = {
        val reversedNums = nums.reverse
        reversedNums.mkString
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, 9l.toLong, 3l.toLong, 1l.toLong, -2l.toLong))).equals(("-2139-1")));
    }

}
