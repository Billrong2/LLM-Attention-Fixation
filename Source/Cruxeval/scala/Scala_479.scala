import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long], pop1: Long, pop2: Long): List[Long] = {
        val buffer = ListBuffer(nums: _*)
        buffer.remove(pop1.toInt - 1)
        buffer.remove(pop2.toInt - 1)
        buffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 5l.toLong, 2l.toLong, 3l.toLong, 6l.toLong)), (2l), (4l)).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
