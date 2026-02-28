import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[String,Long]) : Tuple2[String, Map[String,Long]] = {
        val i = d.size - 1
        val key = d.keys.toList(i)
        val newD = d - key
        (key, newD)
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("e" -> 1l, "d" -> 2l, "c" -> 3l))).equals((("c", Map[String,Long]("e" -> 1l, "d" -> 2l)))));
    }

}
