import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        val reversed = lst.reverse
        val popped = reversed.dropRight(1)
        popped.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](7l.toLong, 8l.toLong, 2l.toLong, 8l.toLong))).equals((List[Long](8l.toLong, 2l.toLong, 8l.toLong))));
    }

}
