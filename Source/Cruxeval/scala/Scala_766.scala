import scala.math._
import scala.collection.mutable._
object Problem {
    def f(values : List[String], value : Long) : Map[String,Long] = {
        val length = values.length
        var newMap = Map[String, Long]()

        for(v <- values) {
            newMap += (v -> value)
        }

        newMap += (values.sorted.mkString("") -> value * 3)
        newMap
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("0", "3")), (117l)).equals((Map[String,Long]("0" -> 117l, "3" -> 117l, "03" -> 351l))));
    }

}
