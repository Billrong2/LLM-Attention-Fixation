import scala.math._
import scala.collection.mutable._
object Problem {
    def f(c : Map[Any,Any], index : Long, value : Long) : Map[Any,Any] = {
        var c1 = c
        c1 += (index -> value)
        if (value >= 3) {
            c1 += ("message" -> "xcrWt")
        } else {
            c1 -= "message"
        }
        c1
    }
    def main(args: Array[String]) = {
    assert(f((Map[Any,Any](1l -> 2l, 3l -> 4l, 5l -> 6l, "message" -> "qrTHo")), (8l), (2l)).equals((Map[Any,Any](1l -> 2l, 3l -> 4l, 5l -> 6l, 8l -> 2l))));
    }

}
