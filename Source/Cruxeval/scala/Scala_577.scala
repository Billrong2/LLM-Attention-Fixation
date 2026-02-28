import scala.collection.immutable._

object Problem {
    def f(items : List[Tuple2[Long, String]]) : List[Map[Long,Long]] = {
        var result = List[Map[Long,Long]]()
        var newItems = items.toMap
        for (i <- 0 until items.length) {
            newItems = newItems - newItems.keysIterator.next()
            result = result :+ newItems.map { case (k, v) => k.toLong -> v.toLong }.toMap
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Tuple2[Long, String]]((1l, "pos")))).equals((List[Map[Long,Long]](Map[Long,Long]()))));
    }

}
