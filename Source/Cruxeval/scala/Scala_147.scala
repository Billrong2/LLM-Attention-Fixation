import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        val middle = nums.length / 2
        nums.slice(middle, nums.length) ++ nums.slice(0, middle)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong, 1l.toLong))).equals((List[Long](1l.toLong, 1l.toLong, 1l.toLong))));
    }

}
