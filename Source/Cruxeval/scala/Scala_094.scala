import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : Map[String,Long], b : Map[String,Long]) : Map[String,Long] = {
        a ++ b
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("w" -> 5l, "wi" -> 10l)), (Map[String,Long]("w" -> 3l))).equals((Map[String,Long]("w" -> 3l, "wi" -> 10l))));
    }

}
