import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : Long = {
        nums(nums.length / 2)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, -3l.toLong, -5l.toLong, -7l.toLong, 0l.toLong))) == (-5l));
    }

}
