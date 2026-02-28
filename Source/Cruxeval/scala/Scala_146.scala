import scala.math._
import scala.collection.mutable._
object Problem {
    def f(single_digit : Long) : List[Long] = {
        var result = ListBuffer[Long]()
        for (c <- 1 until 11) {
            if (c != single_digit) {
                result += c
            }
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((5l)).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong, 6l.toLong, 7l.toLong, 8l.toLong, 9l.toLong, 10l.toLong))));
    }

}
