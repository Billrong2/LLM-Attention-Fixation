import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : Long = {
        var newNums = nums.filter(_ % 2 == 0)
        var sum_ = newNums.sum
        sum_
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](11l.toLong, 21l.toLong, 0l.toLong, 11l.toLong))) == (0l));
    }

}
