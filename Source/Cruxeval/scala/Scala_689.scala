import scala.collection.mutable._
import scala.math._
object Problem {
    def f(arr: List[Long]): List[Long] = {
        val sub = arr.zipWithIndex.map { case (elem, index) =>
            if (index % 2 == 0) elem * 5 else elem
        }
        sub
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-3l.toLong, -6l.toLong, 2l.toLong, 7l.toLong))).equals((List[Long](-15l.toLong, -6l.toLong, 10l.toLong, 7l.toLong))));
    }

}
