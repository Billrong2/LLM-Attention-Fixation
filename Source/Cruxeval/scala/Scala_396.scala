import scala.math._
import scala.collection.mutable._
object Problem {
    def f(ets : Map[Long,Long]) : Map[Long,Long] = {
        var map = ets
        while (map.nonEmpty) {
            val (k, v) = map.head
            map += (k -> v*v)
            map -= k
        }
        map
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]())).equals((Map[Long,Long]())));
    }

}
