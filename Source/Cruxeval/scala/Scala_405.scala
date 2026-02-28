import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(xs: List[Long]): List[Long] = {
        val buffer = ListBuffer(xs: _*)
        var new_x = buffer.head - 1
        buffer.remove(0)
        while (new_x <= buffer.head) {
            buffer.remove(0)
            new_x -= 1
        }
        buffer.prepend(new_x)
        buffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 3l.toLong, 4l.toLong, 1l.toLong, 2l.toLong, 3l.toLong, 5l.toLong))).equals((List[Long](5l.toLong, 3l.toLong, 4l.toLong, 1l.toLong, 2l.toLong, 3l.toLong, 5l.toLong))));
    }

}
