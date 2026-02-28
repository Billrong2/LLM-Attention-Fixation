import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        nums.filter(_ % 2 != 0)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, 3l.toLong, 3l.toLong, 7l.toLong))).equals((List[Long](5l.toLong, 3l.toLong, 3l.toLong, 7l.toLong))));
    }

}
