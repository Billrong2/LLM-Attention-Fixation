import scala.collection.mutable._
import scala.math._
object Problem {
    def f(counts: Map[String, Long]): Map[Any, Any] = {
        var dict = Map[Any, List[String]]()
        for ((k, v) <- counts) {
            val count = counts(k)
            if (!dict.contains(count)) {
                dict += (count -> List[String]())
            }
            dict += (count -> (dict(count) :+ k))
        }
        counts ++ dict
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("2" -> 2l, "0" -> 1l, "1" -> 2l))).equals((Map[Any,Any]("2" -> 2l, "0" -> 1l, "1" -> 2l, 2l -> List[String]("2", "1"), 1l -> List[String]("0")))));
    }

}
