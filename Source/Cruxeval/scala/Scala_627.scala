import scala.math._
import scala.collection.mutable._
object Problem {
    def f(parts : List[Tuple2[String, Long]]) : List[Long] = {
        val partsDict = parts.toMap
        partsDict.values.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Tuple2[String, Long]](("u", 1l), ("s", 7l), ("u", -5l)))).equals((List[Long](-5l.toLong, 7l.toLong))));
    }

}
