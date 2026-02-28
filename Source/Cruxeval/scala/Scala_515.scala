import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        var result = array.reverse.map(_ * 2)
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong, 5l.toLong))).equals((List[Long](10l.toLong, 8l.toLong, 6l.toLong, 4l.toLong, 2l.toLong))));
    }

}
