import scala.collection.mutable._
import scala.math._
object Problem {
    def f(n : Long, m : Long) : List[Long] = {
        var arr = List.range(1L, n + 1)
        for (i <- 1L to m) {
            arr = List.empty[Long]
        }
        arr
    }
    def main(args: Array[String]) = {
    assert(f((1l), (3l)).equals((List[Long]())));
    }

}
