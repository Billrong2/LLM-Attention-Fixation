import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long], mode : Long) : List[Long] = {
        var result = lst.toList
        if (mode != 0) {
            result = result.reverse
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong)), (1l)).equals((List[Long](4l.toLong, 3l.toLong, 2l.toLong, 1l.toLong))));
    }

}
