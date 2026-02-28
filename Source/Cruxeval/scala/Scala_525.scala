import scala.collection.mutable._
import scala.math._
object Problem {
    def f(c : Map[String,Long], st : Long, ed : Long) : Tuple2[String, String] = {
        var d = Map[Long, String]()
        var a, b = ""
        for ((x, y) <- c) {
            d += (y -> x)
            if (y == st) {
                a = x
            }
            if (y == ed) {
                b = x
            }
        }
        val w = d(st)
        if (a > b) {
            (w, d(ed))
        } else {
            (d(ed), w)
        }
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("TEXT" -> 7l, "CODE" -> 3l)), (7l), (3l)).equals((("TEXT", "CODE"))));
    }

}
