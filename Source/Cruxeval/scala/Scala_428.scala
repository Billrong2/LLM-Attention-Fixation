import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var i = 0
        while (i < nums.length) {
            if (i % 2 == 0) {
                nums :+ (nums(i) * nums(i + 1))
            }
            i += 1
        }
        nums
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
