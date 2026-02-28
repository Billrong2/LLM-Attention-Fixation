import scala.math._
import scala.collection.mutable._
object Problem {
    def f(m : List[Long]) : List[Long] = {
        m.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-4l.toLong, 6l.toLong, 0l.toLong, 4l.toLong, -7l.toLong, 2l.toLong, -1l.toLong))).equals((List[Long](-1l.toLong, 2l.toLong, -7l.toLong, 4l.toLong, 0l.toLong, 6l.toLong, -4l.toLong))));
    }

}
