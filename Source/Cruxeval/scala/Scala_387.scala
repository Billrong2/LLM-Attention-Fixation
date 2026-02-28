import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], pos : Long, value : Long) : List[Long] = {
        var newList = nums.toBuffer
        newList.insert(pos.toInt, value)
        newList.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 1l.toLong, 2l.toLong)), (2l), (0l)).equals((List[Long](3l.toLong, 1l.toLong, 0l.toLong, 2l.toLong))));
    }

}
