import scala.collection.mutable._
import scala.math._
object Problem {
    def f(a: List[Long]): List[Long] = {
        if (a.length >= 2 && a(0) > 0 && a(1) > 0) {
            a.reverse
        } else {
            a :+ 0L
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long](0l.toLong))));
    }

}
