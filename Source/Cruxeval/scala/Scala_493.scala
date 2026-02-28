import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[String,String]) : List[String] = {
        var keys = List[String]()
        for ((k, v) <- d) {
            keys = keys :+ s"$k => $v"
        }
        keys
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]("-4" -> "4", "1" -> "2", "-" -> "-3"))).equals((List[String]("-4 => 4", "1 => 2", "- => -3"))));
    }

}
