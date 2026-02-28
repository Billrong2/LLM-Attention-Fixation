import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], target : Long) : Long = {
        val cnt = nums.count(_ == target)
        cnt * 2
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong)), (1l)) == (4l));
    }

}
