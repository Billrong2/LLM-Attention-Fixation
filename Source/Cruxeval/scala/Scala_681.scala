import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[Long], ind: Long, elem: Long): List[Long] = {
        val index = if (ind < 0) -5 else if (ind > array.length) array.length else (ind + 1).toInt
        val (before, after) = array.splitAt(index)
        (before :+ elem) ++ after
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 5l.toLong, 8l.toLong, 2l.toLong, 0l.toLong, 3l.toLong)), (2l), (7l)).equals((List[Long](1l.toLong, 5l.toLong, 8l.toLong, 7l.toLong, 2l.toLong, 0l.toLong, 3l.toLong))));
    }

}
