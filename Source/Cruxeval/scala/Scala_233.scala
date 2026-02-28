import scala.math._
import scala.collection.mutable._
object Problem {
    def f(xs : List[Long]) : List[Long] = {
        var new_xs = xs
        for (idx <- Range.inclusive(-xs.length, -1, -1)) {
            val popped = new_xs.head
            new_xs = new_xs.tail :+ popped
        }
        new_xs.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
