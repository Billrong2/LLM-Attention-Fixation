import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,Long]) : List[Long] = {
        val result = Array.ofDim[Long](d.size)
        var a, b = 0
        var key = 0L
        while (d.nonEmpty) {
            val item = if(a == b) d.head  else d.last
            result(a) = item._2
            d -= item._1
            a = b
            b = (b + 1) % result.length
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]())).equals((List[Long]())));
    }

}
