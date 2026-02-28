import scala.math._
import scala.collection.mutable._
object Problem {
    def f(update : Map[String,Long], starting : Map[String,Long]) : Map[String,Long] = {
        var d = starting.clone()
        for ((k, v) <- update) {
            if (d.contains(k)) {
                d(k) += v
            } else {
                d(k) = v
            }
        }
        return d
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]()), (Map[String,Long]("desciduous" -> 2l))).equals((Map[String,Long]("desciduous" -> 2l))));
    }

}
