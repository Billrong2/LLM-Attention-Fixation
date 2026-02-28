import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,String]) : Map[Long,String] = {
        var r = Map[Long, String]()
        while (d.nonEmpty) {
            r = r ++ d
            val maxKey = d.keys.max
            d -= maxKey
        }
        r
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,String](3l -> "A3", 1l -> "A1", 2l -> "A2"))).equals((Map[Long,String](3l -> "A3", 1l -> "A1", 2l -> "A2"))));
    }

}
