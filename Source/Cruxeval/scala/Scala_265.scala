import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,Long], k : Long) : Map[Long,Long] = {
        var new_d = Map[Long, Long]()
        for ((key, value) <- d) {
            if (key < k) {
                new_d += (key -> value)
            }
        }
        new_d
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](1l -> 2l, 2l -> 4l, 3l -> 3l)), (3l)).equals((Map[Long,Long](1l -> 2l, 2l -> 4l))));
    }

}
