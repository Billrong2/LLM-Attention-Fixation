import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        nums.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-6l.toLong, -2l.toLong, 1l.toLong, -3l.toLong, 0l.toLong, 1l.toLong))).equals((List[Long](1l.toLong, 0l.toLong, -3l.toLong, 1l.toLong, -2l.toLong, -6l.toLong))));
    }

}
