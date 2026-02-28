import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers: List[Long], elem: Long, idx: Long): List[Long] = {
        numbers.take(idx.toInt) ++ List(elem) ++ numbers.drop(idx.toInt)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong)), (8l), (5l)).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 8l.toLong))));
    }

}
