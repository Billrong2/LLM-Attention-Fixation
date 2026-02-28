import scala.math._
import scala.collection.mutable._
object Problem {
    def f(keys : List[Long], value : Long) : Map[Long,Long] = {
        var d = Map[Long, Long]()
        for (k <- keys) {
            d += k -> value
        }
        var copy = d.clone()
        for (i <- d.keys.toList.sorted) {
            if (d(i) == copy(i)) {
                d -= i
            }
        }
        d
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 1l.toLong, 1l.toLong)), (3l)).equals((Map[Long,Long]())));
    }

}
