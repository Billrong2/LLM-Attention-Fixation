import scala.math._
import scala.collection.mutable._
object Problem {
    def f(orig : List[Long]) : List[Long] = {
        val copy = orig.toList
        copy :+ 100
        orig.init
        copy
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
