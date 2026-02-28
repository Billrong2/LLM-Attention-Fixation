import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long], n: Long): List[Long] = {
        var pos = nums.length
        for (i <- -nums.length until 0) {
            nums.patch(pos, List(nums(i)), 0)
            pos += 1
        }
        nums
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]()), (14l)).equals((List[Long]())));
    }

}
