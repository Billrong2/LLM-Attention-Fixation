import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(arr: List[Long]): List[Long] = {
        val n = arr.filter(_ % 2 == 0)
        val m = n ++ arr
        val result = ListBuffer[Long]()

        for (i <- m.indices) {
            if (m.indexOf(m(i)) < n.length) {
                result += m(i)
            }
        }

        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 6l.toLong, 4l.toLong, -2l.toLong, 5l.toLong))).equals((List[Long](6l.toLong, 4l.toLong, -2l.toLong, 6l.toLong, 4l.toLong, -2l.toLong))));
    }

}
