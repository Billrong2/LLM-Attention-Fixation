import scala.math._
import scala.collection.mutable._
object Problem {
    def f(list_x : List[Long]) : List[Long] = {
        var new_list = List.empty[Long]
        for (i <- list_x.reverse) {
            new_list = new_list :+ i
        }
        new_list
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, 8l.toLong, 6l.toLong, 8l.toLong, 4l.toLong))).equals((List[Long](4l.toLong, 8l.toLong, 6l.toLong, 8l.toLong, 5l.toLong))));
    }

}
