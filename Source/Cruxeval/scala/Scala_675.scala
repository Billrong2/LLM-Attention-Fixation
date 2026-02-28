import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], sort_count : Long) : List[Long] = {
        val sortedNums = nums.sorted
        sortedNums.take(sort_count.toInt)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 2l.toLong, 3l.toLong, 4l.toLong, 5l.toLong)), (1l)).equals((List[Long](1l.toLong))));
    }

}
