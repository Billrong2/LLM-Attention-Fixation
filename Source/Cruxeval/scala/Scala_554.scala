import scala.math._
import scala.collection.mutable._
object Problem {
    def f(arr : List[Long]) : List[Long] = {
        arr.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 0l.toLong, 1l.toLong, 9999l.toLong, 3l.toLong, -5l.toLong))).equals((List[Long](-5l.toLong, 3l.toLong, 9999l.toLong, 1l.toLong, 0l.toLong, 2l.toLong))));
    }

}
