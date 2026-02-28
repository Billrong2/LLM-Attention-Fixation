import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Map[String,Long] = {
        var freq = Map[String, Long]()
        for (c <- text.toLowerCase) {
            if (freq.contains(c.toString)) {
                freq += c.toString -> (freq(c.toString) + 1)
            } else {
                freq += c.toString -> 1
            }
        }
        freq
    }
    def main(args: Array[String]) = {
    assert(f(("HI")).equals((Map[String,Long]("h" -> 1l, "i" -> 1l))));
    }

}
