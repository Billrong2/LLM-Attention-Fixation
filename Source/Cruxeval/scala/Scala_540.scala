import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : List[Long]) : List[Long] = {
        var b = a.toList
        for (k <- 0 until a.length - 1 by 2) {
            b = b.patch(k + 1, Seq(b(k)), 0)
        }
        b :+ b(0)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, 5l.toLong, 5l.toLong, 6l.toLong, 4l.toLong, 9l.toLong))).equals((List[Long](5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong, 6l.toLong, 4l.toLong, 9l.toLong, 5l.toLong))));
    }

}
