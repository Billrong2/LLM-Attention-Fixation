import scala.math._
import scala.collection.mutable._
object Problem {
    def f(obj : Map[String,Long]) : Map[String,Long] = {
        obj.map { case (k, v) =>
            if (v >= 0) {
                (k, -v)
            } else {
                (k, v)
            }
        }
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("R" -> 0l, "T" -> 3l, "F" -> -6l, "K" -> 0l))).equals((Map[String,Long]("R" -> 0l, "T" -> -3l, "F" -> -6l, "K" -> 0l))));
    }

}
