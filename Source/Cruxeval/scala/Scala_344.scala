import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        val operation: List[Long] => Unit = (x => x.reverse)
        val new_list = lst.sorted
        operation(new_list)
        lst
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 4l.toLong, 2l.toLong, 8l.toLong, 15l.toLong))).equals((List[Long](6l.toLong, 4l.toLong, 2l.toLong, 8l.toLong, 15l.toLong))));
    }

}
