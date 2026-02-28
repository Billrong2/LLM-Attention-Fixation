import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : List[Long], b : List[Long]) : List[Long] = {
        val sorted_a = a.sorted
        val sorted_b = b.sorted(Ordering[Long].reverse)
        sorted_a ++ sorted_b
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](666l.toLong)), (List[Long]())).equals((List[Long](666l.toLong))));
    }

}
