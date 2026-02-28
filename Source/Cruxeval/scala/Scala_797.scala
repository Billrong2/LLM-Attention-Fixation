import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dct : Map[String,Long]) : List[Tuple2[String, Long]] = {
        var lst = List.empty[Tuple2[String, Long]]
        for ((key, value) <- dct.toSeq.sortBy(_._1)) {
            lst = lst :+ (key, value)
        }
        lst
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("a" -> 1l, "b" -> 2l, "c" -> 3l))).equals((List[Tuple2[String, Long]](("a", 1l), ("b", 2l), ("c", 3l)))));
    }

}
