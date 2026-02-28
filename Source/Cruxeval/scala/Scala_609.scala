import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : Map[Long,Long], elem : Long) : Map[Long,Long] = {
        var result = array
        while (result.nonEmpty) {
            val (key, value) = result.head
            if (elem == key || elem == value) {
                result ++= array
            }
            result -= key
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]()), (1l)).equals((Map[Long,Long]())));
    }

}
