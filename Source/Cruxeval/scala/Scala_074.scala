import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long], i : Long, n : Long) : List[Long] = {
        lst.patch(i.toInt, List(n), 0)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](44l.toLong, 34l.toLong, 23l.toLong, 82l.toLong, 24l.toLong, 11l.toLong, 63l.toLong, 99l.toLong)), (4l), (15l)).equals((List[Long](44l.toLong, 34l.toLong, 23l.toLong, 82l.toLong, 15l.toLong, 24l.toLong, 11l.toLong, 63l.toLong, 99l.toLong))));
    }

}
