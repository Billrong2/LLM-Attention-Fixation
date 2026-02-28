import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
    val new_array = array.reverse
    new_array.map(x => x*x)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 1l.toLong))).equals((List[Long](1l.toLong, 4l.toLong, 1l.toLong))));
    }

}
