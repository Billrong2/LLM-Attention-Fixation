import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dict1 : Map[String,Long], dict2 : Map[String,Long]) : Map[String,Long] = {
        var result = dict1 ++ dict2
        result
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("disface" -> 9l, "cam" -> 7l)), (Map[String,Long]("mforce" -> 5l))).equals((Map[String,Long]("disface" -> 9l, "cam" -> 7l, "mforce" -> 5l))));
    }

}
