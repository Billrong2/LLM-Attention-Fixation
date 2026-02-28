import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], i_num : Long, elem : Long) : List[Long] = {
        val index = i_num.toInt
        val result = array.take(index) ::: List(elem) ::: array.drop(index)
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-4l.toLong, 1l.toLong, 0l.toLong)), (1l), (4l)).equals((List[Long](-4l.toLong, 4l.toLong, 1l.toLong, 0l.toLong))));
    }

}
