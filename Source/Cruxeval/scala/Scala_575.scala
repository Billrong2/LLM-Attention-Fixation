import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long], value: Long): Long = {
        val newList = nums.flatMap(i => List.fill(value.toInt)(i))
        newList.sum
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](10l.toLong, 4l.toLong)), (3l)) == (42l));
    }

}
