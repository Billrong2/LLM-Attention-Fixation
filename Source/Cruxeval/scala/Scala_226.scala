import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        nums.flatMap(n => if (n % 3 == 0) List(n, n) else List(n))
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 3l.toLong, 3l.toLong))));
    }

}
