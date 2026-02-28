import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        var res = ListBuffer[Long]()

        for (i <- lst.indices) {
            if (lst(i) % 2 == 0) {
                res += lst(i)
            }
        }

        return lst.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong))));
    }

}
