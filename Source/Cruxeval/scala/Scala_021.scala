import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[Long]): List[Long] = {
        val buffer = ListBuffer(array: _*)
        val n = buffer.last
        buffer.trimEnd(1)
        buffer += n
        buffer += n
        buffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong, 2l.toLong, 2l.toLong))).equals((List[Long](1l.toLong, 1l.toLong, 2l.toLong, 2l.toLong, 2l.toLong))));
    }

}
