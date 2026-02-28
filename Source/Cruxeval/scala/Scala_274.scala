import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], target : Long) : Long = {
        var count = 0
        for (n1 <- nums) {
            for (n2 <- nums) {
                count += { if (n1 + n2 == target) 1 else 0 }
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong)), (4l)) == (3l));
    }

}
