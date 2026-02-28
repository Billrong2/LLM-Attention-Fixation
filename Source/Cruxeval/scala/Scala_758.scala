import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : Boolean = {
        if (nums.reverse == nums) {
            true
        } else {
            false
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 3l.toLong, 6l.toLong, 2l.toLong))) == (false));
    }

}
