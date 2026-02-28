import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], target : Long) : Long = {
        if(nums.count(_ == 0) > 0) {
            return 0
        } else if(nums.count(_ == target) < 3) {
            return 1
        } else {
            return nums.indexOf(target).toLong
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 2l.toLong)), (3l)) == (1l));
    }

}
