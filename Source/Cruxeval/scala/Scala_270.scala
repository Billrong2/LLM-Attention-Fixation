import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dic : Map[Long,Long]) : Map[Long,Long] = {
        var d: Map[Long,Long] = Map()
        for (key <- dic.keys.toList) {
            d += (key -> dic.getOrElse(key, 0l))
        }
        d
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]())).equals((Map[Long,Long]())));
    }

}
