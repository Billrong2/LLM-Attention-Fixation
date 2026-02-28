import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var asc = nums.toList
        var desc = asc.reverse.take(asc.length / 2)
        desc ++ asc ++ desc
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
