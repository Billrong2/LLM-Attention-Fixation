import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        var array_2 = List[Long]()
        for (i <- array) {
            if (i > 0) {
                array_2 = i :: array_2
            }
        }
        array_2.sorted.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](4l.toLong, 8l.toLong, 17l.toLong, 89l.toLong, 43l.toLong, 14l.toLong))).equals((List[Long](89l.toLong, 43l.toLong, 17l.toLong, 14l.toLong, 8l.toLong, 4l.toLong))));
    }

}
