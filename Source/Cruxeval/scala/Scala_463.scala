import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dict : Map[Long,Long]) : Map[Long,Long] = {
        var result = dict
        for ((k, v) <- dict) {
            if (dict.contains(v)) {
                result -= k
            }
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](-1l -> -1l, 5l -> 5l, 3l -> 6l, -4l -> -4l))).equals((Map[Long,Long](3l -> 6l))));
    }

}
