import scala.math._
import scala.collection.mutable._
object Problem {
    def f(num : List[Long]) : List[Long] = {
        num :+ num.last
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-70l.toLong, 20l.toLong, 9l.toLong, 1l.toLong))).equals((List[Long](-70l.toLong, 20l.toLong, 9l.toLong, 1l.toLong, 1l.toLong))));
    }

}
