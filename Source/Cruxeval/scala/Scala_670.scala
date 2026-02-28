import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : List[String], b : List[Long]) : List[Long] = {
        val d = a.zip(b).toMap
        a.sortBy(-d.getOrElse(_, 0L)).map(d.getOrElse(_, 0L))
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("12", "ab")), (List[Long](2l.toLong, 2l.toLong))).equals((List[Long](2l.toLong, 2l.toLong))));
    }

}
