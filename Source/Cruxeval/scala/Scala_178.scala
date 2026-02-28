import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], n : Long) : List[Long] = {
        array.drop(n.toInt)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 0l.toLong, 1l.toLong, 2l.toLong, 2l.toLong, 2l.toLong, 2l.toLong)), (4l)).equals((List[Long](2l.toLong, 2l.toLong, 2l.toLong))));
    }

}
