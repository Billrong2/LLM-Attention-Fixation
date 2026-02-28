import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], start : Long, k : Long) : List[Long] = {
        nums.patch(start.toInt, nums.slice(start.toInt, start.toInt + k.toInt).reverse, k.toInt)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong, 5l.toLong, 6l.toLong)), (4l), (2l)).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong, 6l.toLong, 5l.toLong))));
    }

}
