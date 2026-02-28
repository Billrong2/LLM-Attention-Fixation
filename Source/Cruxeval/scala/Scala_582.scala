import scala.math._
import scala.collection.mutable._
object Problem {
    def f(k : Long, j : Long) : List[Long] = {
        var arr = ListBuffer[Long]()
        for (i <- 1 to k.toInt) {
            arr += j
        }
        arr.toList
    }
    def main(args: Array[String]) = {
    assert(f((7l), (5l)).equals((List[Long](5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong, 5l.toLong))));
    }

}
