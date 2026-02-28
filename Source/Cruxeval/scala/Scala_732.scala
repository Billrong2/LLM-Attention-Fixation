import scala.math._
import scala.collection.mutable._
object Problem {
    def f(char_freq : Map[String,Long]) : Map[String,Long] = {
        var result = Map[String, Long]()
        for ((k, v) <- char_freq.toMap) {
            result += (k -> (v / 2))
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("u" -> 20l, "v" -> 5l, "b" -> 7l, "w" -> 3l, "x" -> 3l))).equals((Map[String,Long]("u" -> 10l, "v" -> 2l, "b" -> 3l, "w" -> 1l, "x" -> 1l))));
    }

}
