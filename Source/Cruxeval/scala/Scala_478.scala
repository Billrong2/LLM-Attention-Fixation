import scala.math._
import scala.collection.mutable._
object Problem {
    def f(sb : String) : Map[String,Long] = {
        var d = Map[String, Long]()
        for (s <- sb) {
            d += s.toString -> (d.getOrElse(s.toString, 0L) + 1)
        }
        d
    }
    def main(args: Array[String]) = {
    assert(f(("meow meow")).equals((Map[String,Long]("m" -> 2l, "e" -> 2l, "o" -> 2l, "w" -> 2l, " " -> 1l))));
    }

}
