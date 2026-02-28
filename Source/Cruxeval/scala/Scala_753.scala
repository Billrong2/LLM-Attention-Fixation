import scala.math._
import scala.collection.mutable._
object Problem {
    def f(bag : Map[Long,Long]) : Map[Long,Long] = {
        var values = bag.values.toList
        var tbl = Map[Long,Long]()
        for (v <- 0l until 100l) {
            if (values.contains(v)) {
                tbl += v -> values.count(_ == v)
            }
        }
        tbl
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](0l -> 0l, 1l -> 0l, 2l -> 0l, 3l -> 0l, 4l -> 0l))).equals((Map[Long,Long](0l -> 5l))));
    }

}
