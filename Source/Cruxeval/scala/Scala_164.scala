import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        val sortedList = lst.sorted
        sortedList.take(3)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, 8l.toLong, 1l.toLong, 3l.toLong, 0l.toLong))).equals((List[Long](0l.toLong, 1l.toLong, 3l.toLong))));
    }

}
