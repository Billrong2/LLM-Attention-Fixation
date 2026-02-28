import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,Long]) : List[Tuple2[Long, Long]] = {
    val sortedPairs = d.toList.sortBy{ case (k, v) => (k.toString + v.toString).length }
    sortedPairs.filter{ case (k, v) => k < v }
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](55l -> 4l, 4l -> 555l, 1l -> 3l, 99l -> 21l, 499l -> 4l, 71l -> 7l, 12l -> 6l))).equals((List[Tuple2[Long, Long]]((1l, 3l), (4l, 555l)))));
    }

}
