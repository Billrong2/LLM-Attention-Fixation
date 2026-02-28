import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,Long], count : Long) : Map[Long,Long] = {
        var i = 0
        while ({i < count && d.nonEmpty}) {
            d -= d.keys.head
            i += 1
        }
        d
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]()), (200l)).equals((Map[Long,Long]())));
    }

}
