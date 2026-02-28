import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], idx : Long, added : Long) : List[Long] = {
        nums.patch(idx.toInt, List(added), 0)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 2l.toLong, 2l.toLong, 3l.toLong, 3l.toLong)), (2l), (3l)).equals((List[Long](2l.toLong, 2l.toLong, 3l.toLong, 2l.toLong, 3l.toLong, 3l.toLong))));
    }

}
