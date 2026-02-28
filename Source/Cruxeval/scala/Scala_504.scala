import scala.math._
import scala.collection.mutable._
object Problem {
    def f(values : List[Long]) : List[Long] = {
        values.sorted
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong))).equals((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong))));
    }

}
